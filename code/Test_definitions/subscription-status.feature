Feature: CAMARA SubscriptionStatus API, v0.1-rc.1 - Retrieve subscription status of a phone number


Background: Common setup
    Given the resource "/subscription-status/v0.1rc1/retrieve-subscription-status"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value

# Happy path scenarios

@subscriptionStatus_1_valid_request
Scenario: Retrieve status for valid phone number
    Given a valid phone number "+123456789"
    And the request body contains the phone number
    When the HTTP "POST" request is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response body contains valid status values
    And the response property "$.voiceSmsIn" is either "active" or "suspended"
    And the response property "$.voiceSmsOut" is either "active" or "suspended"
    And the response property "$.dataService" is either "active", "suspended" or "throttled"

# Error scenarios

@subscriptionStatus_2_invalid_phone_format
Scenario: Error for invalid phone number format
    Given an invalid phone number "123456" (non E.164 format)
    And the request body contains the invalid phone number
    When the HTTP "POST" request is sent
    Then the response status code is 400
    And the response contains error code "INVALID_ARGUMENT"

@subscriptionStatus_3_phone_not_found
Scenario: Error for non-existent phone number
    Given a valid but non-existent phone number "+999999999"
    And the request body contains this phone number
    When the HTTP "POST" request is sent
    Then the response status code is 404
    And the response contains error code "IDENTIFIER_NOT_FOUND"

@subscriptionStatus_4_missing_phone
Scenario: Error when phone number is missing
    Given an empty request body
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response contains error code "MISSING_IDENTIFIER"

@subscriptionStatus_5_expired_token
Scenario: Error for expired access token
    Given an expired access token
    And a valid request body with phone number
    When the HTTP "POST" request is sent
    Then the response status code is 401
    And the response contains error code "UNAUTHENTICATED"

@subscriptionStatus_6_insufficient_permissions
Scenario: Error for insufficient permissions
    Given an access token with insufficient permissions
    And a valid request body with phone number
    When the HTTP "POST" request is sent
    Then the response status code is 403
    And the response contains error code "PERMISSION_DENIED"

@subscriptionStatus_7_service_unavailable
Scenario: Error when service not available
    Given a phone number for which service is unavailable
    And the request body contains this phone number
    When the HTTP "POST" request is sent
    Then the response status code is 422
    And the response contains error code "SERVICE_NOT_APPLICABLE"
