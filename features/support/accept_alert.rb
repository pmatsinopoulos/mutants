def accept_alert
  page.driver.browser.switch_to.alert.accept if [:selenium, :selenium_firefox].include?(Capybara.javascript_driver)
end