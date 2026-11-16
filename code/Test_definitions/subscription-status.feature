Feature: CAMARA Subscription Status API, vwip - Operation retrieveSubscriptionStatus

  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * apiRoot: API root of the server URL
  #
  # Testing assets:
  # * Phone numbers (E.164 format) whose mobile subscription is in each of the states
  #   exercised below: all services active, Voice/SMS inbound suspended,
  #   Voice/SMS outbound suspended, data service suspended, data service throttled,
  #   and more than one service suspended at the same time.
  # * A phone number commercialized by the implementation for which the service is
  #   not applicable, if any.
  #
  # References to OAS spec schemas refer to schemas specified in subscription-status.yaml

  Background: Common setup
    Given an environment at "apiRoot"
    And the resource "/subscription-status/vwip/retrieve-subscription-status"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema at "#/components/schemas/SubscriptionStatusRequest"

  # Happy path scenarios
  #
  # The subscription status of a phone number is a combination of three independent
  # service statuses. These scenarios validate that each status is reported
  # independently and correctly for the corresponding subscription state.

  @subscriptionStatus_01_all_services_active
  Scenario: Retrieve the status of a phone number whose services are all active
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose Voice/SMS inbound, Voice/SMS outbound and data services are all active
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "active"
    And the response property "$.voiceSmsOut" is "active"
    And the response property "$.dataService" is "active"

  @subscriptionStatus_02_voice_sms_inbound_suspended
  Scenario: Retrieve the status of a phone number whose Voice/SMS inbound service is suspended
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose Voice/SMS inbound service is suspended
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "suspended"
    And the response property "$.voiceSmsOut" is "active"
    And the response property "$.dataService" is "active"

  @subscriptionStatus_03_voice_sms_outbound_suspended
  Scenario: Retrieve the status of a phone number whose Voice/SMS outbound service is suspended
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose Voice/SMS outbound service is suspended
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "active"
    And the response property "$.voiceSmsOut" is "suspended"
    And the response property "$.dataService" is "active"

  @subscriptionStatus_04_data_service_suspended
  Scenario: Retrieve the status of a phone number whose data service is suspended
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose data service is suspended
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "active"
    And the response property "$.voiceSmsOut" is "active"
    And the response property "$.dataService" is "suspended"

  @subscriptionStatus_05_data_service_throttled
  Scenario: Retrieve the status of a phone number whose data service is throttled
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose data service is throttled
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "active"
    And the response property "$.voiceSmsOut" is "active"
    And the response property "$.dataService" is "throttled"

  @subscriptionStatus_06_multiple_services_suspended
  Scenario: Retrieve the status of a phone number whose voice/SMS services are suspended while data service is active
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a phone number whose Voice/SMS inbound and outbound services are suspended
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is "suspended"
    And the response property "$.voiceSmsOut" is "suspended"
    And the response property "$.dataService" is "active"

  @subscriptionStatus_07_phone_number_from_access_token
  Scenario: Retrieve the status of the phone number identified by the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And the request body property "$.phoneNumber" is not included
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/SubscriptionStatusResponse"
    And the response property "$.voiceSmsIn" is one of "active", "suspended"
    And the response property "$.voiceSmsOut" is one of "active", "suspended"
    And the response property "$.dataService" is one of "active", "suspended", "throttled"

  # Error scenarios

  @subscriptionStatus_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "#/components/schemas/PhoneNumber"
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_08_request_body_not_schema_compliant
  Scenario: Request body contains a property not declared in the API specification
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body contains the property "$.unexpectedProperty" which is not declared in the API specification
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_09_no_authorization_header
  Scenario: Error response for no header "Authorization"
    Given the header "Authorization" is not sent
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_10_expired_access_token
  Scenario: Error response for expired access token
    Given the header "Authorization" is set to an expired access token
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_11_invalid_access_token
  Scenario: Error response for invalid access token
    Given the header "Authorization" is set to an invalid access token
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_12_permission_denied
  Scenario: Access token does not have the required scope
    Given the header "Authorization" is set to a valid access token without the scope "subscription-status:retrieve-subscription-status"
    And the request body property "$.phoneNumber" is set to a valid phone number
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 404
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And the request body property "$.phoneNumber" is set to a valid phone number
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deduced from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  @subscriptionStatus_13_too_many_requests
  Scenario: Request is rejected because a rate limit has been exceeded
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is set to a valid phone number
    And the API consumer has exceeded the number of requests allowed in the period defined by the implementation
    When the request "retrieveSubscriptionStatus" is sent
    Then the response status code is 429
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has the same value as the request header "x-correlator"
    And the response property "$.status" is 429
    And the response property "$.code" is "TOO_MANY_REQUESTS"
    And the response property "$.message" contains a user friendly text
