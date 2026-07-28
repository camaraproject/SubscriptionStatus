# API Readiness Checklist

Checklist for subscription-status v0.2.0 in release r2.1

| Nr | API release assets | alpha | release-candidate | public-release<br>initial | public-release<br>stable | Status | Reference information |
|----|----------------------------------------------|:-----:|:-----------------:|:-------------------------:|:------------------------:|:------:|:----------------------|
| 1  | API definition                               |   M   |         M         |             M             |             M            |   Y    | [link](/code/API_definitions/subscription-status.yaml) |
| 2  | Design guidelines from Commonalities applied |   O   |         M         |             M             |             M            |   Y    | [r4.3](https://github.com/camaraproject/Commonalities/releases/tag/r4.3) |
| 3  | Guidelines from ICM applied                  |   O   |         M         |             M             |             M            |   Y    | [r4.2](https://github.com/camaraproject/IdentityAndConsentManagement/releases/tag/r4.2) |
| 4  | API versioning convention applied            |   M   |         M         |             M             |             M            |   Y    | `version: wip` on `main`; target release `v0.2.0` handled by release automation |
| 5  | API documentation                            |   M   |         M         |             M             |             M            |   Y    | Embedded documentation into API spec - [link](/code/API_definitions/subscription-status.yaml) |
| 6  | User stories                                 |   O   |         O         |             O             |             M            |   N    | |
| 7  | Basic API test cases & documentation         |   O   |         M         |             M             |             M            |   Y    | [link](/code/Test_definitions/subscription-status.feature) |
| 8  | Enhanced API test cases & documentation      |   O   |         O         |             O             |             M            |   Y    | [link](/code/Test_definitions/subscription-status.feature) |
| 9  | Test result statement                        |   O   |         O         |             O             |             M            |   N    | To be provided |
| 10 | API release numbering convention applied     |   M   |         M         |             M             |             M            |   Y    | [link](/release-plan.yaml) |
| 11 | Change log updated                           |   M   |         M         |             M             |             M            |   N    | Generated during the release-review workflow as `CHANGELOG-r2.1.md` |
| 12 | Previous public-release was certified        |   O   |         O         |             O             |             M            |   N    | |
| 13 | API description (for marketing)              |   O   |         O         |             M             |             M            |   N    | Follow-up item from the KYC working-group minutes of July 7, 2026 |

Note: As of July 28, 2026, this checklist reflects the pre-snapshot state for the Sync26 `r2.1` release candidate.
