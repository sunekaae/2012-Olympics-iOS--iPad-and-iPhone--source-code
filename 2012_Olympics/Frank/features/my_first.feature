@rotating
Feature: 
  As an iOS developer
  I want to have a sample feature file
  So I can see what my next step is in the wonderful world of Frank/Cucumber testing

Scenario: 
    Rotating the simulator for demonstration purposes
Given I launch the app
Then I save a screenshot with prefix rotating
Given the device is in landscape orientation
Then I save a screenshot with prefix rotating
Given the device is in portrait orientation
Then I save a screenshot with prefix rotating
Given the device is in landscape orientation
Then I save a screenshot with prefix rotating
Given the device is in portrait orientation
Then I save a screenshot with prefix rotating
