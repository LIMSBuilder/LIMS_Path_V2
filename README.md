#实验室信息管理系统 第二版

#访问地址
> http://lims.qulongjun.cn

#更新细节
##版本v2.0
####更新日期：2016-11-01
即日起，开放第二版管理系统的部分功能的内测，现在可以通过访问链接地址：http://lims.qulongjun.cn/login  进行访问，目前已经开放的功能有：部门管理、角色管理、用户注册、用户管理（仅添加用户功能）、合同起草、合同查询、预设信息管理、监测频次管理、环境要素管理、监测项目管理。在使用中，你可以对上述模块的所有功能进行各项测试，若在测试过程中遇到问题，可以点击系统上方的“问题反馈”按钮进行反馈，我这边能够查看你的反馈信息。其他功能我会在接下来陆续开放。浏览器建议使用高版本的Chrome浏览器。

##版本v2.1
####更新日期：2016-11-04
实验室信息管理系统内测版本更新至V2.1，现在可以直接访问http://lims.qulongjun.cn/ 体验最新更新，本次更新如下模块：
####开放模块：
1. 合同审核模块
1. 任务创建模块
1. 自建任务查询模块
1. 承接科室设置模块
目前流程为：合同起草->合同审核->合同修改(若未通过)/任务创建（若通过)
注意：
1.在第一次登录系统之后，需要对系统部分模块进行初始化
   1.部门管理模块
   2.角色管理模块
2.在创建合同之前，需对部分合同项进行初始化操作，包括如下：
   1.预设信息管理模块：合同起草时导入乙方信息
   2.监测频次管理模块：合同检测项目的监测频次
   3.环境要素管理模块：监测项目类别
   4.监测项目管理模块：合同监测项目
   5.客户管理模块：合同起草时导入甲方信息
3.在创建任务书之前，需对部分合同项进行初始化操作
   1.合同起草模块之前的所有模块
   2.承接科室管理模块：控制流程走向

##版本v2.2
####更新日期：2016-11-16
实验室信息管理系统内测版本更新至V2.2，现在可以直接访问http://lims.qulongjun.cn/ 体验最新更新，本次更新内容较多，依次如下：
####开放模块：
1. 用户登录模块：现在需要用户登录才能进入LIMS系统了，若之前注册过的用户，需要重新进行注册才能进入系统。
1. 合同审核模块：现在新创建的合同需要经过审核，且审核结果为“审核通过”才能进入任务流程了。
1. 样品登记模块：自送样/现场采样将统一在样品登记模块对样品进行操作。取消V1.0版本中的自送样登记/现场采样登记功能。
1. 样品交联模块：现在系统会自动根据样品和监测项目之间的关系生成交联信息了。
1. 样品接收模块：更加智能的接收样品，允许管理员分次接收样品，并对样品接收进行标记。
1. 项目质控模块：操作员现在只需要通过在样品后面打钩即可快速的对项目进行质控，且支持多次质控和多条件的质控。
1. 任务分配模块：操作者可以更加直观的对任务进行分配了，支持批量分配和单独指定功能。
1. 送检单管理模块：支持自定义上传送检单，允许为环境要素单独绑定送检单。

####修复细节：
1. 更为完善的“开发中”提示，目前尚未开放的模块将显示“Comming soon”。
1. 修复合同模板无法使用的问题。
1. 用户登录进行验证，验证不通过将无法登录。
1. 表单验证功能更加完善。
1. 更加完善的列表提示，用户现在可以很容易区分合同模板与真实合同了。
1. 加入进度查询功能，支持合同进度查询和任务进度查询。
1. 监测项目新增“负责科室”字段，以备将来使用。
1. 修复任务创建（来自合同/自定义）之间的差异。
1. 现在可以“中止任务”和“中止合同”了。
1. 其他影响用户体验的问题。