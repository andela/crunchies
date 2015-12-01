from selenium import webdriver
 
driver = webdriver.Chrome() 
driver.get("http://techcrunch.com/event-info/9th-annual-crunchies-awards/")
 
diversity_form = driver.find_element_by_id("crunchies_nomination_7")
input_diversity = diversity_form.find_element_by_name("name")
input_diversity.click()
input_diversity.send_keys("Andela") 
input_diversity.submit()


social_impact_form = driver.find_element_by_id("crunchies_nomination_8")
input_social_impact = social_impact_form.find_element_by_name("name")
input_social_impact.click()
input_social_impact.send_keys("Andela") 
input_social_impact.submit()

driver.quit()