---
title: Use cases for Remote Attestation common encodings
abbrev: useful RATS
docname: draft-richardson-rats-usecases-00

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

This document exists as place to collect use cases in support of the
IETF RATS charter point 1.  This document is not expected to be published
as an RFC, but remain open as a working document.  It could become
an appendix to provide motivation for a protocol standards document.

# Terminology          {#Terminology}

Critical to dealing with and constrasting different technologies is to
collect terms with are compatible, to distinguish those terms which are
similar but used in different ways.

This section will grow to include forward and external references to terms
which have been seen.  When terms need to be disambiguated they will be
prefixed with their source, such as "TCG(claim)" or "FIDO(relying party)"

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

This proposal is a work-in-progress, and is available to TCG members only.
The goal is to be multi-vendor, scalable and extensible.   The proposal
intentionally limits itself to:

* "non-privacy-preserving applications (i.e., networking, Industrial IoT )",
* that the firmware is provided by the device manufacturer
* that there is a physical Trusted Platform Module (TPM)

The proposal is intended to provide an assurance to a network operator
that the equipment on *their* network can be reliably identified.

Specifically listed to be out of scope includes: Linux processes, assemblies
of hardware/software created by end-customers, and equipment that is sleepy.

The TCG Attestion leverages the TPM to make a series of measurements during
the boot process, and to have the TPM sign those measurements.  The resulting
"PCG" hashes are then available to an external verifier.

The TCG uses the following terminology:

* Device Manufacuter
* Attester ("device under attestation")
* Verifier (Network Management Station)
* Reference Integrity Measurements (RIM), which are signed my device
  manufacturer and integrated into firmware.
* Quotes: measured values (having been signed), and RIMs
* Reference Integrity Values (RIV)
* devices have a Initial Attestion Key (IAK), which is provisioned at the
same time as the IDevID.
* PCR ?
* PCG ?

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

This specification is very much focused on authenticating user from devices with
humans attached to them.

# Privacy Considerations.

TBD

# Security Considerations

TBD.

# IANA Considerations

TBD.

# Acknowledgements

--- back

