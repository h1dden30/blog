---
title: "VPNs are dead. Switch to mTLS."
type: blog
tags: [homelab, authentik, traefik]
---

It feels like I've been talking about mTLS every week since I've initially deployed it in my homelab.

## Software

- **Traefik v2.11** as the reverse proxy, with mTLS.
- **Authentik** running as forward-auth in front of everything that isn't already gated by mTLS.
- A router split: LAN traffic takes one path, WAN traffic gets the full auth flow.

You don't need to be a genius to understand that one layer of defense was never enough. If that was the case, doors wouldnt have a second lock on them! In this case, an advesary would need to obtain a certificate, bypass the passphrase, *and* SSO auth *and* before any internal resources are touched.

Obviously, this isn't a full replacement for a VPN. In instances where you need routing, you will be able to setup sufficient layers. My use case is accessing web servers. Then again, solutions like Gucamole exist, so your SSH and RDP connections would be done through your web browser.
