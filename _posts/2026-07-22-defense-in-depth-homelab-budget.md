---
title: "Defense in depth on a homelab budget: Authentik + mTLS + Traefik"
type: blog
tags: [homelab, authentik, traefik]
---

A quick overview of how the identity and reverse-proxy layer in `nebula` fits
together — the pattern that made me actually trust exposing homelab services
to the internet at all.

## The stack

- **Traefik v2.11** as the reverse proxy, with mTLS enforced via an internal
  AD CS two-tier PKI
- **Authentik** running as forward-auth in front of everything that isn't
  already gated by mTLS
- A router split: LAN/Tailscale-trusted traffic takes one path, WAN traffic
  gets the full auth gate

## The part that actually matters

Any single layer here is beatable. The point isn't any one control — it's that
an attacker has to clear certificate-based mTLS *and* SSO auth *and* be on a
trusted network path before they're touching anything real. That's the actual
definition of defense in depth, not just a buzzword for "I have a firewall."

Full architecture writeup with the Traefik dynamic config and Authentik
provider setup coming as a research post once I've documented the mTLS
bootstrapping process properly.
