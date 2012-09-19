Feature: rubyc helps you with the shell
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
      |reject|
