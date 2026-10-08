---
layout: post
title: "Burn-Rate Alerts"
date: 2026-10-07
mermaid: true
categories:
  - Learning
description: "How an error budget turns into alerts that page me for a fast problem and open a ticket for a slow one, with the arithmetic worked out."
---
Last time I wrote down what an SLI, an SLO, and an error budget are. An SLO doesn't do anything on its own, though. Something has to watch the budget and tell you when you're burning through it too fast. That's a burn-rate alert, and the part that took me the longest to get was where the time window comes in.

## Burn rate

Burn rate is how fast you're using up the error budget. If you're failing at exactly the rate your SLO allows, the burn rate is 1 and the budget lasts the whole period, which is 30 days for my SLOs. If you're failing twice as fast, the burn rate is 2 and the budget is gone in 15 days.

Here are the three formulas:

```text
error rate seen = failed requests / total requests
burn rate       = error rate seen / error rate allowed
days to empty   = days in the SLO period / burn rate
```

The requests are counted over a window, which I'll get to in a minute. The error rate allowed comes from your SLO. At 99.9% it's 0.1%. The SLO period is how long your SLO covers, which is 30 days for mine. A 14-day SLO would use 14 in that last formula.

| Burn rate | Days until the budget is gone (30-day period) |
|---|---|
| 1 | 30 |
| 2 | 15 |
| 10 | 3 |
| 14.4 | about 2 |

## The window

You never measure "the error rate" in the abstract. You measure it over a window, like the last hour. The window only tells you which stretch of time to count failures and total requests in. A different window counts a different stretch, and the formulas stay the same.

Here's a real example. Pi-hole answers about 30,000 queries a day, which is roughly 1,250 an hour. Here are two different hours at a 99.9% SLO:

| | An hour with 18 failures | An hour with 2 failures |
|---|---|---|
| Total queries | 1,250 | 1,250 |
| Error rate seen | 1.44% | 0.16% |
| Error rate allowed | 0.1% | 0.1% |
| Burn rate | 14.4 | 1.6 |
| What should happen | The fast alert pages me | Nothing |

18 failures in an hour is a burn rate of 14.4, so the budget would be gone in about 2 days. That's the number the fast alert watches for, and it's why that hour is worth a page. 2 failures is a burn rate of 1.6, which is just noise.

You can also work out how much budget one hour at a given burn rate costs:

```text
budget used = burn rate x hours / hours in the SLO period
```

My period is 30 days, which is 720 hours (30 x 24). So an hour at 14.4 uses 14.4 / 720, which is 2% of the month's budget.

## Three alerts, two windows each

The Workbook doesn't use one alert. It uses three, each tied to how much of the budget you're willing to lose before somebody hears about it.

| Alert | Burn rate | Long window | Short window | Budget spent in the long window | What happens |
|---|---|---|---|---|---|
| Fast | 14.4 | 1h | 5m | 2% | Page |
| Medium | 6 | 6h | 30m | 5% | Page |
| Slow | 3 | 1d | 2h | 10% | Ticket |

Fast and severe problems page me. A slow leak only opens a ticket, since it can wait until morning.

Each alert looks at two windows, and both have to be over the threshold for it to fire. The long window tells you the problem is real and not a blip. The short window tells you it's still happening. Without the short one, the alert would keep firing after you fixed the problem, because the long window still has the failures in it until they age out. With it, the alert stops as soon as the last few minutes are clean.

The numbers aren't magic. Each one comes from the budget formula above, with my 720 hours: the fast row is 14.4 x 1 / 720 = 2%, and the slow row is 3 x 24 / 720 = 10%.

```mermaid
flowchart TD
    A("Pick a window") --> B("failures / total calls in that window")
    B --> C("÷ allowed error rate = burn rate")
    C --> D{"Over this window's threshold,<br/>in the long and the short window?"}
    D -- "14.4x over 1h, or 6x over 6h" --> E("Page"):::bad
    D -- "3x over 1d" --> F("Ticket"):::warn
    classDef bad fill:#d08770,stroke:#a85a44,color:#2e3440
    classDef warn fill:#ebcb8b,stroke:#b8974c,color:#2e3440
```

One thing I didn't expect: the Workbook's third alert is 1x over 3 days. Datadog won't take a window longer than 48 hours, so I used Datadog's version, 3x over 1 day. It spends the same 10% of the budget. I use the same three on both Grafana and Datadog so they behave the same.

## A bug I found in my own alert

On Grafana I can't ask for "both windows over the threshold" directly, so my alert compares the smaller of the two burn rates against the threshold. That works, except for one case I only found while reviewing it. If one window has no data, the `min()` quietly ignores it, and the alert fires on the other window alone. That's exactly what the two windows were supposed to prevent. I tested it against Prometheus to be sure, then added a guard that keeps the alert quiet unless both windows have a value.

## Pi-hole, and why I left the fast alert off

The Pi-hole SLO is built on a DNS probe that runs once a minute. With one probe a minute, a single failed probe in an hour is 1 out of 60, or 1.7%. That's a burn rate of 16.7, which is over 14.4. One blip would page me.

So Pi-hole only has the medium and slow alerts. Medium needs a burn rate of 6 over 6 hours, which is about 3 failed probes out of 360 (2 gets you 5.6, just under). That tells a real problem from a blip. The cost is that a 2-minute outage doesn't page me in real time.

You can see how it's set up in [the Pi-hole SLO definition](https://github.com/Mosher-Labs/homelab-gitops/blob/0801da680aa7c29c7db2ac24f2885536295227e8/infrastructure/observability-alerts/locals.tf#L84), where `tiers = ["medium", "slow"]` is the one line that leaves the fast alert off. The three tiers and the thresholds are defined [in the module](https://github.com/Mosher-Labs/terraform-kubernetes-observability/blob/v0.17.0/modules/slo/locals.tf#L8), and the burn rate for each window is worked out from the budget share.

I tested the alerts the same way as before. I made temporary copies of the two Pi-hole alerts, fed them a fake 95% success rate, and watched both fire and then resolve in Slack and Webex.

## The short version

Burn rate is the error rate you see divided by the one you're allowed. Pick a window, count over it, and compare it to that window's threshold. The two windows keep the alert honest, and a quiet service needs fewer alerts, not more.

The sources are the Workbook's chapter on [alerting on SLOs](https://sre.google/workbook/alerting-on-slos/) and Datadog's page on [burn rate alerts](https://docs.datadoghq.com/service_level_objectives/burn_rate/). The first post in this pair covers the [SLI, SLO, and error budget side](/learning/2026/10/06/slis-slos-and-error-budgets.html).
