---
title: Use cases for Remote Attestation common encodings
abbrev: useful RATS
docname: draft-richardson-rats-usecases-02

# stand_alone: true

ipr: trust200902
area: Internet
wg: RATS Working Group
kw: Internet-Draft
cat: info

coding: us-ascii
pi:    # can use array (if all yes) or hash here
  toc: yes
  sortrefs:   # defaults to yes
  symrefs: yes

author:


- ins: M. Richardson
  name: Michael Richardson
  org: Sandelman Software Works
  email: mcr+ietf@sandelman.ca

normative:
  RFC2119:
informative:
  I-D.tschofenig-rats-psa-token:
  keystore:
    target: "https://developer.android.com/training/articles/keystore"
    title: "Android Keystore System"
    author:
      ins: "Google"
      date: 2019

  android_security:
    target: "https://arxiv.org/pdf/1904.05572.pdf"
    title: "The Android Platform Security Model"
    author:
      name: "René Mayrhofer and Jeffrey Vander Stoep and Chad Brubaker and Nick Kralevich",
      date; 2019

  fido_w3c:
    target: https://www.w3.org/TR/webauthn-1/
    title: "Web Authentication: An API for accessing Public Key Credentials Level 1"
    author:
      ins: "W3C"
      date: "2019"
  fido:
    target: "https://fidoalliance.org/specifications/"
    title: "FIDO Specification Overview"
    author:
      ins: "FIDO Alliance"
      date: 2019

  fidotechnote:
    target: "https://fidoalliance.org/fido-technotes-the-truth-about-attestation/"
    title: "FIDO TechNotes: The Truth about Attestation"
    author:
      ins: "FIDO Alliance"
      date: "2018-07-19"

  fidoattestation:
    target: "https://fidoalliance.org/specs/fido-v2.0-ps-20150904/fido-key-attestation-v2.0-ps-20150904.html"
    title: "FIDO 2.0: Key Attestation"
    author:
      ins: "FIDO Alliance"
      date: 2015

  fidosignature:
    target: "https://fidoalliance.org/specs/fido-v2.0-ps-20150904/fido-signature-format-v2.0-ps-20150904.html"
    title: "FIDO 2.0: Signature Format"
    author:
      ins: "FIDO Alliance"
      date: 2019


--- abstract

This document details mechanisms created for performing Remote Attestation
that have been used in a number of industries.  The document intially focuses
on existing industry verticals, mapping terminology used in those
specifications to the more abstract terminology used by RATS.

The document (aspires) goes on to go on to describe possible future
use cases that would be enabled by common formats.

--- middle

# Introduction

The recently chartered IETF RATS WG intends to create a system of
attestations that can be shared across a multitude of different users.

This document exists as place to collect use cases for the common RATS
technologies in support of the IETF RATS charter point 1.  This document is
not expected to be published as an RFC, but remain open as a working
document.  It could become an appendix to provide motivation for a protocol
standards document.

This document will probably not deal with use cases from an end-user point of
view, but rather on the technology verticals that wish to use RATS concepts
(such as EAT) in their deployments.

End-user use cases that would either directly leverage RATS technology, or
would serve to inform technology choices are welcome, however.

# Terminology          {#Terminology}

Critical to dealing with and constrasting different technologies is to
collect terms with are compatible, to distinguish those terms which are
similar but used in different ways.

This section will grow to include forward and external references to terms
which have been seen.  When terms need to be disambiguated they will be
prefixed with their source, such as "TCG(claim)" or "FIDO(relying party)"

Platform attestions generally come in two categories. This document will
attempt to indicate for a particular attestion technology falls into this.

## Static attestions

A static attestion says something about the platform on which the code is running.

## Session attestions

A session attestion says something about how the shared session key was
created.

## Statements

The term "statement" is used as the generic term for the semantic content
which is being attested to.

# Requirements Language {#rfc2119}

This document is not a standards track document and does not make any
normative protocol requirements using terminology described in {{RFC2119}}.

# Overview of Sources of Use Cases

The following specifications have been convered in this document:

* The Trusted Computing Group "Network Attestation System" (private document)
* Android Keystore
* Fast Identity Online (FIDO) Alliance attestation,

This document will be expanded to include summaries from:

* Trusted Computing Group (TCG) Trusted Platform Module (TPM)/Trusted
Software Stack (TSS)
* ARM "Platform Security Architecture" {{I-D.tschofenig-rats-psa-token}}

# Use case summaries

## Trusted Computing Group (TCG)

The TCG is trying to solve the problem of knowing if a networking device
should be part a network.  If it belongs to the operator, and if it running
approriate software.

This proposal is a work-in-progress, and is available to TCG members only.
The goal is to be multi-vendor, scalable and extensible.   The proposal
intentionally limits itself to:

* "non-privacy-preserving applications (i.e., networking, Industrial IoT )",
* that the firmware is provided by the device manufacturer
* that there is a manufacturer installed hardware root of trust (such as a
  TPM and boot room)

Service providers and enterprises deploy hundreds of routers, many of them in
remote locations where they're difficult to access or secure.  The point of
remote attestation is to:

* identify a remote box in a way that's hard to spoof
* report the inventory of software was launched on the box in a way that can
  not be spoofed

The use case described is to be able to monitor the authenticity of software
versions and configurations running on each device.  This allows owners and
auditors to detect deviation from approved software and firmware versions and
configurations, potentially identifying infected devices.

Attestation may be performed by network management systems.  Networking
Equipment is often highly interconnected, so it’s also possible that
attestation could be performed by neighboring devices.

Specifically listed to be out of scope includes: Linux processes, assemblies
of hardware/software created by end-customers, and equipment that is sleepy
(check term).

The TCG Attestion leverages the TPM to make a series of measurements during
the boot process, and to have the TPM sign those measurements.  The resulting
"PCG" hashes are then available to an external verifier.

The TCG uses the following terminology:

* Device Manufacuter
* Attester ("device under attestation")
* Verifier (Network Management Station)
* "Explicit Attestation" is the TCG term for a static (platform) statement.
* "Implicit Attestation" is the TCG term for a session statement.
* Reference Integrity Measurements (RIM), which are signed my device
  manufacturer and integrated into firmware.
* Quotes: measured values (having been signed), and RIMs
* Reference Integrity Values (RIV)
* devices have a Initial Attestion Key (IAK), which is provisioned at the
same time as the IDevID.
* PCR - Platform Configuration Registry (deals with hash chains)

The TCG document builds upon a number of IETF technologies: SNMP (Attestion
MIB), YANG, XML, JSON, CBOR, NETCONF, RESTCONF, CoAP, TLS and SSH.
The TCG document leverages the 802.1AR IDevID and LDevID processes.


## Android Keystore system

{{keystore}} describes a system used in smart phones that run the Android
operation system.   The system is primarily a software container to contain
and control access to cryptographic keys, and therefore provides many of the
same functions that a hardware Trusted Platform Module might provide.

On hardware which is supported, the Android Keystore will make use of
whatever trusted hardware is available, including use of Trusted Execution
Environment (TEE) or Secure Element (SE)).  The Keystore therefore abstracts
the hardware, and guarantees to applications that the same APIs can be used
on both more and less capable devices.

A great deal of focus from the Android Keystore seems to be on providing
fine-grained authorization of what keys can be used by which applications.

XXX - clearly there must be additional (intended?) use cases that provide
some kind of attestion.

Android 9 on Pixel 2 and 3 can provided protected confirmation messages.
This uses hardware access from the TPM/TEE to display a message directly to
the user, and receives confirmation directly from the user.  A hash of the
contents of the message can provided in an attestation that the device
provides.

In addition, the Android Keystore provides attestion information about itself
for use by FIDO.

QUOTE: Finally, the Verified Boot state is included in key attestation
certificates (provided by Keymaster/Strongbox) in the deviceLocked and
verifiedBootState fields, which can be verified by apps as well as
passed onto backend services to remotely verify boot integrity [**21]



## Fast IDentity Online (FIDO) Alliance

The FIDO Alliance {{fido}} has a number of specifications aimed primarily at
eliminating the need for passwords for authentication to online services.
The goal is to leverage asymmetric cryptographic operations in common
browser and smart-phone platforms so that users can easily authentication.

FIDO specifications extend to various hardware second factor authentication
devices.

Terminology includes:

* "relying party" validates a claim
* "relying party application" makes FIDO Authn calls
* "browser" provides Web Authentication JS API
* "platform" is the base system
* "internal authenticator" is some credential built-in to the device
* "external authenticator" may be connected by USB, bluetooth, wifi, and may
  be an stand-alone device, USB connected key, phone or watch.

FIDO2 had a Key Attestion Format {{fidoattestation}}, and a Signature Format
{{fidosignature}}, but these have been combined into the W3C document
{{fido_w3c}} specification.

The FIDO use case involves a relying party that wants to have the HW/SW
implementation does a biometric check on the human to be strongly attested.

FIDO does provides a transport in the form of the WebAuthn and FIDO CTAP
protocols.

According to {{fidotechnote}} FIDO uses attestion to make claims about the
kind of device which is be used to enroll.  Keypairs are generated on a
per-device *model* basis, with a certificate having a trust chain that leads
back to a well-known root certificate.  It is expected that as many as
100,000 devices in a production run would have the same public and private
key pair.  One assumes that this is stored in a tamper-proof TPM so it is
relatively difficult to get this key out.  The use of this key attests to the
the device type, and the kind of protections for keys that the relying party
may assume, not to the identity of the end user.


# Privacy Considerations.

TBD

# Security Considerations

TBD.

# IANA Considerations

TBD.

# Acknowledgements

--- back

# Changes

- added comments from Guy, Jessica, Henk and Ned on TCG description.
