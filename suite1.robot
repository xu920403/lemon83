*** Settings ***
Library           DateTime
Library           Collections
Library           String
Library           SeleniumLibrary

*** Variables ***
${global_scalar}    100    #这是一个全局的变量
@{global_list}    guagua    boluo    bay    dabao    #定义了一个全局的列表
&{global_dict}    name=boluo    age=18    city=shanghai    #定义了一个全局字典

*** Test Cases ***
case_lesson01
    Log    瓜瓜是大佬！！    WARN    #打印这个信息    #ctrl+3注释；Ctrl+4取消注释
    Should Be Equal    100    100    #断言
    ${date}    Get Current Date
    add_function    30    #调用这个用户关键字    #调用这个用户关键字

case_lesson02
    [Documentation]    RF变量：根据数据类型分类--3种
    ...    标量（scalar）：${var_name}==单个数据的存在
    ...    列表（list）：@{var_name}
    ...    注意：列表不是一个单一数据，每一个元素都是独立的数据存在==多个数据的存在类型
    ...    字典：&{var_name}
    ...    注意：字典不是一个单一数据，每一个元素都是独立的数据存在==多个数据的存在类型
    ...    位置不同，变量分两种：
    ...    1.局部变量：在测试用例里定义的只能在当前测试用例的范围内使用，跨测试用例使用会报错
    ...    2.全局变量：套件suite里设置（标量，列表，字典）
    ...    3.可以把局部变量设置为全局变量--共享出来 \ 但是共享的case要同时运行
    ...    Set Global Variable#将变量设置成全局变量
    ...    Set Suite Variable#将变量设置成suite套件都能用的变量
    ${var_scalar}    Set Variable    hello world!    #定义变量，并做了赋值
    log    ${var_scalar}
    #定义一个列表
    @{var_list}    Create List    abc    青栀子    小于    ling
    Log    ${var_list}    #强制转化为标量再打印
    Log Many    @{var_list}    #分别打印列表的每一个元素
    log    ${var_list}[1]    #列表的取值
    Append To List    ${var_list}    dabao    #列表增加元素，在末尾追加
    log    ${var_list}
    Remove From List    ${var_list}    2    #删除列表索引号为2的元素
    Insert Into List    ${var_list}    1    小鱼    #在列表索引号为1的前面插入元素
    log    ${var_list}
    Get Length    ${var_list}
    #定义字典
    &{var_dict}    Create Dictionary    name=guagua    age=18    city=shanghai
    Log Many    &{var_dict}
    log    ${var_dict}
    Pop From Dictionary    ${var_dict}    age    vbn
    Remove From Dictionary    ${var_dict}    city    abc
    log    ${var_dict}
    Set Global Variable    ${var_scalar}    #将变量设置成全局变量
    Set Suite Variable    ${var_scalar}    #将变量设置成suite套件都能用的变量

case2_lesson02
    [Documentation]    控制流：
    ...    if判断if判断：注意ELSE IF，ELSE要大写
    ...    for循环:
    ...    1.FOR+列表
    ...    2.FOR+IN RANGE
    ...    注意：FOR END大写 \ \ \ \换行符新版本不需要用了
    ...
    ...    大写的关键字：
    ...    ELSE IF ,ELSE,IN RANGE,FOR END
    ...    其他的关键字大小写不敏感
    log    ${global_scalar}
    log    ${global_list}
    log    ${global_dict}
    log    ${var_scalar}    #上一个用例设置了全局之后，别的用例可以调用
    #if判断
    ${var_money}    Set Variable    200
    Run Keyword If    ${var_money}>=200    log    buy big house
    ...    ELSE IF    ${var_money}>=100    log    buy small house
    ...    ELSE IF    ${var_money}>=50    log    buy a car
    ...    ELSE    log    work hard
    #FOR+列表
    FOR    ${item}    IN    @{global_list}    #遍历列表，需要元素是单个存在的，用@符号
        log    ${item}
        Exit For Loop If    '${item}'=='boluo'
    END
    FOR    ${item}    IN    ${global_list}    #用$符号，不会遍历，会整体输出
        log    ${item}
    END
    #FOR循环+in range
    FOR    ${num}    IN RANGE    10
        LOG    ${num}
    END

case_lesson3
    [Documentation]    绝对路径：从根开始，一级一级找路径
    ...    相对路径：从中间开始找，不是从根开始---灵活
    ...    元素定位方法：8种
    ...    xpath---再用
    ...    id----优先
    ...    name---优先
    ...
    ...    注意：id虽然唯一，但是可能是变化的，此时不能用来做唯一定位---iframe子页面
    Open Browser    http://erp.lemfix.com/login.html    gc    #用谷歌浏览器打开erp网址
    Maximize Browser Window    #最大化浏览器
    ${title}    Get Title    #获取页面的标题
    Comment    Title Should Be    柠檬ERP    #标题的断言
    Comment    Should Be Equal    ${title}    柠檬ERP    #断言标题是否是柠檬ERP
    Run Keyword If    '${title}'=='柠檬ERP'    LOG    测试通过
    ...    ELSE    LOG    测试不通过    #if判断做断言
    ${page_text}    Get Text    xpath=/html/body/div/div/div[1]/a/b    #获取页面元素的文本
    Should Be Equal    ${page_text}    柠檬ERP    #断言
    ${page_text2}    Get Text    xpath=/html/body/div/div/div[1]/a/small
    Should Be Equal    ${page_text2}    V1.3
    Comment    Click Element    xpath=//*[@id="username"]    #点击用户名输入框    #相对路径
    Comment    Click Element    username    #id="username"，用id的值    #name定位也可以这样用
    Comment    Click Element    password    Click Element可点击按钮属性的，也可以点击输入框
    Click Element    xpath=//label[1]/div/ins    #点击复选框‘记住账号’
    Comment    Close Browser
    Comment    Close Window
    Comment    Close All Browsers    #关闭浏览器
    Input Text    username    test123    #输入用户名
    Input Password    password    123456    #输入密码，如果对执行结果不要求密码保密，也可以用input text
    Click Button    btnSubmit    #确定是按钮属性的就用click button关键字，不是的话点击就用click element，button少用
    #判断登录成功
    Comment    Sleep    3    #等待3s，强制等待
    Wait Until Element Is Visible    xpath=//div[2]/p    #等待元素可见就不再等了,默认是5是，可以自己加时间
    ${user_name}    Get Text    xpath=//div[2]/p    #获取文本
    Should Be Equal    ${user_name}    测试用户    #断言

case_lesson04
    [Documentation]    1.等待：sleep，wait
    ...    2.id如果是变化的，不能用来做标识
    ...    3.页面有嵌套的---iframe，不能直接定位，需要切换iframe
    #用户菜单与预期一致
    ${tab_count}    Get Element Count    xpath=//*[@id="leftMenu"]/ul/li    #菜单个数
    ${tab_relname}    Create List    零售管理    采购管理    销售管理    仓库管理    财务管理    报表查询    商品管理    基本资料
    ${tab_exename}    Create List    #空列表，存放页面中取出来的元素
    FOR    ${num}    IN RANGE    ${tab_count}
        ${tab_name}    Get Text    xpath=//*[@id="leftMenu"]/ul/li[${num}+1]/a/span
        Comment    Should Be Equal    ${tab_name}    ${tab_relname}[${num}]    #将得到的元素与${tab_relname}[${num}]取出的元素做对比
        Append To List    ${tab_exename}    ${tab_name}    #把页面取出来的元素存进空的列表里面
    END
    log    ${tab_exename}
    Should Be Equal    ${tab_exename}    ${tab_relname}    #列表做一个断言
    Click Element    xpath=//*[@id="leftMenu"]/ul/li[1]/ul/li[1]/a/span    #点击菜单
    Comment    Wait Until Element Is Visible    //*[@class="tabpanel_mover"]/li[2]/div[1]
    ${ls_tabname}    Get Text    xpath=//*[@class="tabpanel_mover"]/li[2]/div[1]    #如果Iid是变化的，不能用来定位，只能通过父节点来定位
    Should Be Equal    ${ls_tabname}    零售出库    #断言，判断页面以打开
    #在打开页面中空搜索
    ${id}    Get Element Attribute    xpath=//*[@class="tabpanel_mover"]/li[2]    id    #通过零售出库的父节点得到id属性
    ${iframe_id}    Set Variable    ${id}-frame    #得到iframe的id
    Select Frame    ${iframe_id}    #切换frame--子页面，通过frameid
    ${row_num_before}    Get Element Count    xpath=//*[@id="tablePanel"]/div/div/div[2]/div[2]/div[2]/table/tbody/tr    #搜索前得到当前结果的行数
    Click Element    searchNumber    #找到搜索框，点击
    Input Text    searchNumber    ${EMPTY}    #搜索框里输入为空
    Click Element    searchBtn    #点击查询按钮
    ${row_num_after}    Get Element Count    xpath=//*[@id="tablePanel"]/div/div/div[2]/div[2]/div[2]/table/tbody/tr    #获取空搜索结果的行数
    Should Be Equal    ${row_num_after}    ${row_num_before}    #搜索前后的行数一样，断言
    #搜索448
    Input Text    searchNumber    448
    Click Element    searchBtn    #点击查询按钮
    Sleep    2    #搜索结果获取有点慢，加个等待2s
    ${row_num_448}    Get Element Count    xpath=//*[@id="tablePanel"]/div/div/div[2]/div[2]/div[2]/table/tbody/tr
    Should Be Equal As Integers    ${row_num_448}    1    #这个448搜索数量是1，这个1 的数量以后项目中可以从数据库中读取
    #搜索314，不存在的
    Input Text    searchNumber    314
    Click Element    searchBtn    #点击查询按钮
    Sleep    2
    ${row_num_314}    Get Element Count    xpath=//*[@id="tablePanel"]/div/div/div[2]/div[2]/div[2]/table/tbody/tr
    Should Be Equal As Integers    ${row_num_314}    0    #314没有的，数量为0做断言

*** Keywords ***
add_function
    [Arguments]    ${num1}    ${num2}=100    # 定义了两个参数--变量
    [Documentation]    RF不是代码，python运算符不能直接使用，使用python的语法需借用关键字
    log    10+20
    ${result}    Evaluate    ${num1}+${num2}    #用了evaluate关键字来计算python表达式，并且用一个变量来接收返回结果
