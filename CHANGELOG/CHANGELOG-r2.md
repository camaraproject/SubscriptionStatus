# Changelog SubscriptionStatus

<!-- TOC:START -->
## Table of Contents
- [r2.1](#r21)
<!-- TOC:END -->

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

# r2.1

## Release Notes

This release candidate contains the definition and documentation of
* subscription-status 0.2.0-rc.1

The API definition(s) are based on
* Commonalities 0.8.0
* Identity and Consent Management 0.5.0

## subscription-status 0.2.0-rc.1

**subscription-status 0.2.0-rc.1 is a release-candidate version of this API.**

Changes documented below are compared to version 0.1.0.

- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SubscriptionStatus/r2.1/code/API_definitions/subscription-status.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SubscriptionStatus/r2.1/code/API_definitions/subscription-status.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/SubscriptionStatus/blob/r2.1/code/API_definitions/subscription-status.yaml)

### Breaking changes

* Renamed the endpoint path from `/retrive-subscription-status` to `/retrieve-subscription-status`, including the corresponding OAuth2 scope `subscription-status:retrieve-subscription-status`, tag and `operationId` (typo fix with impact on API consumers) by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36
* Aligned the phone number identification behaviour with the CAMARA guidelines: when a three-legged access token is used, the optional `phoneNumber` MUST NOT be provided in the request body; if it is provided anyway, the server now responds with `422 UNNECESSARY_IDENTIFIER` instead of `403 INVALID_TOKEN_CONTEXT` by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36

### Added

* Added a test scenario for the `422 UNNECESSARY_IDENTIFIER` error when a phone number is unnecessarily provided with a three-legged access token by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36

### Changed

* Renamed the endpoint path from `/retrive-subscription-status` to `/retrieve-subscription-status`, including the corresponding OAuth2 scope, tag and `operationId` by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36
* Aligned the phone number identification behaviour with the CAMARA guidelines: when a three-legged access token is used, the optional `phoneNumber` MUST NOT be provided in the request body; if it is provided anyway, the server now responds with `422 UNNECESSARY_IDENTIFIER` by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36
* Aligned the API definition with Commonalities r4.3 and ICM r4.2 requirements for the Sync26 meta-release: `x-camara-commonalities` updated to `0.8.0`, common schemas (`PhoneNumber`, `ErrorInfo`, `x-correlator`, `securitySchemes`) now referenced from `CAMARA_common.yaml`, mandatory documentation sections marked with `CAMARA:MANDATORY` markers by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36
* Request bodies with undeclared properties are now rejected with `400 INVALID_ARGUMENT` (`additionalProperties: false` on request and response schemas) by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36
* Updated the error catalogue: removed the `403 INVALID_TOKEN_CONTEXT` error response and updated the `422 UNNECESSARY_IDENTIFIER` example description by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36

### Fixed

* Fixed the typo in the endpoint path, OAuth2 scope, tag and `operationId` (`retrive` -> `retrieve`) by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36

### Removed

* Removed the `403 INVALID_TOKEN_CONTEXT` error response from the API definition, following the alignment with the CAMARA phone number identification guidelines by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/36

**Full Changelog**: https://github.com/camaraproject/SubscriptionStatus/compare/r1.2...r2.1

