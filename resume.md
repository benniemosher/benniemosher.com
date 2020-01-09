---
layout: resume
title: Resume
permalink: "/resume/"
menu:
  main:
    identifier: resume
    weight: 2

---
{% for job in site.jobs reversed %}

<article>
  <h2>{{ job.company }}</h2>
  <h3>{{ job.position }}</h3>
  <h4>{{ job.duration }}, {{ job.location }}</h4>
  <p>{{ job.description }}</p>
</article>

{% endfor %}