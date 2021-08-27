"""
Project: python_class
Author:柠檬班-Tricy
Time:2021/8/24 21:25
Company:湖南零檬信息技术有限公司
Site: http://www.lemonban.com
Forum: http://testingpai.com 
"""
from selenium import webdriver
from common import method  # 从包里导入
from testdata import data

driver = webdriver.Chrome()
driver.implicitly_wait(10)
name = data.test_data.get("name")
passwd = data.test_data.get("passwd")
key = data.test_data.get("key")

num = method.search(driver,name,passwd,key)  # 调用导入的包里的方法
if key in num:
    print("成功！")
else:
    print("失败！")
