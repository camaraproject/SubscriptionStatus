# Changelog Subscription Status

## Table of Contents
- **[r1.1](#r11)**

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release


# r1.1

## Release Notes


This release contains the definition and documentation of
* subscription-status v0.1.0-rc.1

The API definition(s) are based on
* Commonalities v0.6.0-rc.1
* Identity and Consent Management v0.4.0-rc.1



## subscription-status v0.1.0-rc.1

**subscription-status v0.1.0-rc.1 is the first release-candidate version for v0.1.0 of the Subscription Status API.


 API definition **with inline documentation**:
[[YAML]](https://github.com/camaraproject/SubscriptionStatus/blob/r1.1/code/API_definitions/subscription-status.yaml)
[[View it on ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/SubscriptionStatus/r1.1/code/API_definitions/subscription-status.yaml&nocors)
[[View it on Swagger Editor]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/SubscriptionStatus/r1.1/code/API_definitions/subscription-status.yaml)

**Initial contribution of API definitions for Subscription Status**, including initial documentation.

## Added
* Initial yaml file including Subscription Status API by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/6
* Add test file by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/9
* Add text on undocumented errors to OAS definition by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/13

## Removed
* Remove AUTHENTICATION_REQUIRED error code by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/13

## Changed
* Update x-correlator format by @chinaunicomyangfan in https://github.com/camaraproject/SubscriptionStatus/pull/13
