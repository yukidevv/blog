---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
years: ["{{ time.Now.Year }}"]
---