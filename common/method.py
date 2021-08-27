"""
Project: python_class
Author:柠檬班-Tricy
Time:2021/8/24 21:23
Company:湖南零檬信息技术有限公司
Site: http://www.lemonban.com
Forum: http://testingpai.com 
"""
import time
def login(driver,name,passwd):
    driver.get("http://erp.lemfix.com/login.html")
    username = driver.find_element_by_id("username").send_keys(name)
    driver.find_element_by_id("password").send_keys(passwd)
    driver.find_element_by_id("btnSubmit").click()

def search(driver,name,passwd,key):
    login(driver,name,passwd)
    driver.find_element_by_xpath('//span[text()="零售出库"]').click()
    time.sleep(2)
    id = driver.find_element_by_xpath('//div[text()="零售出库"]/..').get_attribute("id") # 获取元素的属性值
    frameid = id + "-frame"
    driver.switch_to.frame(driver.find_element_by_xpath("//iframe[@id='{}']".format(frameid))) # 通过元素定位 切换iframe
    driver.find_element_by_id("searchNumber").send_keys(key)
    driver.find_element_by_id("searchBtn").click()
    time.sleep(1)  # 隐式等待+ 强制等待
    num = driver.find_element_by_xpath('//tr[@id="datagrid-row-r1-2-0"]//td[@field="number"]/div').text # 获取文本
    return num