---
layout: page
title: Resume
permalink: /resume/
---

{% for job in site.jobs reversed %}

<article>
  <h2>{{ job.company }}</h2>
  <h3>{{ job.position }}</h3>
  <h4>{{ job.duration }}, {{ job.location }}</h4>
  <p>{{ job.description }}</p>
</article>

{% endfor %}