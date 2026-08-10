---
title: "Anonymous FTP to alert: closing the loop from HTB box to Wazuh detection"
type: research
tags: [htb, wazuh, detection-engineering]
---

Most HTB writeups stop at the flag. This one doesn't — the actual point of practicing
offense is understanding what the corresponding detection should catch, and then
proving it does.

## The box

Recon started with a standard `nmap` sweep, which turned up an FTP service allowing
anonymous login. From there it was a straight line to the flag — no privilege
escalation chain, no obfuscation, just a misconfigured service.

That simplicity is exactly why it's a good detection case study: a real attacker
wouldn't need anything cleverer than this against a lot of real environments.

## The detection

Rebuilt the same scenario against an FTP service on `nebula`, monitored by Wazuh.
The goal was a rule that fires specifically on **anonymous authentication success**,
not just any FTP connection — connection noise alone isn't a useful signal.

```xml
<rule id="100210" level="10">
  <if_sid>530</if_sid>
  <match>USER anonymous</match>
  <description>Anonymous FTP login attempt detected</description>
  <group>authentication_success,pci_dss_10.2.5,</group>
</rule>
```

## What I'd change in a real environment

- Disable anonymous FTP entirely where it isn't a deliberate business requirement
- If it must stay enabled, alert on it as a standing finding, not just an event —
  the presence of the capability is itself the risk
- Pair the detection rule with an asset inventory check, since "which hosts run FTP"
  is often the harder half of this problem

More writeups like this are coming as I work through HTB Tier 0-1 with a
detection-first lens.
