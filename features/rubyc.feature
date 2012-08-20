Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "rubyc"
    Then the exit status should be 0
    And the following options should be documented:
      |map|
      |select|
      |sum|
      |sort_by|
      |grep|
      |compact|
      |count_by|
      |uniq|
      |merge|
