/**
 * 组件通用Mixin - 页面组件混入
 * 
 * 功能说明：
 * 提供Vue组件通用的数据管理和操作方法，包括增删改查、分页、排序、导入导出等功能。
 * 支持列表显示、详情查询、表单提交等常见业务场景。
 * 
 * 核心功能：
 * - CRUD操作：add(添加)、del(删除)、set(修改)、get(查询)
 * - 列表管理：get_list(查询列表)、first(首页)、next(下一页)、prev(上一页)、goTo(跳转页)
 * - 表单提交：submit(提交表单)、upload(上传文件)
 * - 数据选择：select_all(全选)、select_change(改变选择)、select_has(判断已选)
 * - 导入导出：import_db(导入数据)、export_db(导出数据)
 * - 树形结构：opens_change(展开/收起)、opens_has(判断展开)、opens_lv(获取级别)
 */
export default {
	/**
	 * 组件传入的属性定义
	 */
	props: {
		/** 获取的列表数据 - 存储从服务器查询到的数据列表 */
		list: {
			type: Array,
			default: function () {
				return [];
			}
		},
		/** 视图验证模型 - 用于表单验证的规则集 */
		vm: {
			type: Object,
			default: function () {
				return {}
			}
		},
		/** 提交表单数据 - 用户输入的表单数据，随时准备提交 */
		form: {
			type: Object,
			default: function () {
				return {}
			}
		},
		/** 线上对象 - 从服务器获取的当前编辑对象 */
		obj: {
			type: Object,
			default: function () {
				return {}
			}
		},

	},
	/**
	 * 组件数据状态
	 * 从本地存储获取上次保存的展开状态
	 */
	data: function data() {
		var opens = $.db.get('opens') || [0];  // 从localStorage获取展开的树节点ID
		return {
			/* ==================== 标题和描述 ==================== */
			/** 页面标题 */
			title: "",

			/* ==================== API地址配置 ==================== */
			/** 基础API地址 - 如果设置，其他地址为空时会自动拼接method参数 */
			url: "",
			/** 数据添加API地址 - POST请求，参数为新增数据 */
			url_add: "",
			/** 数据删除API地址 - GET请求，参数为删除条件 */
			url_del: "",
			/** 数据修改API地址 - POST请求，参数为修改数据 */
			url_set: "",
			/** 查询单条数据API地址 - GET请求，参数为查询条件 */
			url_get_obj: "",
			/** 查询列表API地址 - GET请求，支持分页和搜索条件 */
			url_get_list: "",
			/** 表单提交API地址 - POST请求 */
			url_submit: "",
			/** 文件上传API地址 - 使用FormData格式上传 */
			url_upload: "",
			/** 数据导入API地址 - 上传Excel/CSV文件 */
			url_import: "",
			/** 数据导出API地址 - 下载Excel文件 */
			url_export: "",

			/* ==================== 分页和查询配置 ==================== */
			/** 分页配置 - page:当前页码(默认1)，size:每页记录数(默认10) */
			config: {
				page: 1,
				size: 10
			},

			/* ==================== 加载状态 ==================== */
			/** 数据加载进度 - 0~100，用于显示加载条 */
			loading: 0,
			/** 组件显示进度 - 0表示组件未加载完成，100表示加载完成 */
			showing: 0,
			/** 表单提交进度 - 0表示未提交，100表示提交完成 */
			posting: 0,

			/* ==================== 选择和选中状态 ==================== */
			/** 选中项的索引 - 用于列表中标记当前选中的项 */
			select: $.db.get('select'),
			/** 查询结果的总数 - 用于计算分页总页数 */
			count: 0,
			/** 显示/隐藏标志 - true显示，false隐藏模态框或弹窗 */
			show: false,
			/** 操作结果标志 - true成功，false失败 */
			bl: false,

			/* ==================== 字段和显示配置 ==================== */
			/** 显示方式 - 如'grid'(网格)、'list'(列表)等 */
			display: "",
			/** 关键字段名 - 通常是主键字段名，如'user_id'、'product_id' */
			field: "",
			/** 操作提示信息 - 显示操作结果的消息 */
			tip: "",
			/** 操作模式 - 'list'(列表模式)或其他模式 */
			mode: "list",
			/** 是否清除列表 - 查询前是否清空原列表数据 */
			clear_list: true,
			/** 错误消息 - 操作失败时的错误提示 */
			message: "",

			/* ==================== 多选和批量操作 ==================== */
			/** 选中项集合 - 用'|'分隔的ID字符串，如'1|2|3' */
			selects: "",
			/** 当前显示的页码 - 用于跳转页面 */
			page_now: 1,
			/** 全选状态 - true表示已全选，false表示未全选 */
			select_state: false,
			/** 排序键 - 拖拽修改排序时使用，通常为'display'或'sort' */
			sort_key: "display",
			/** 修改条件 - 修改操作时的WHERE条件 */
			query_set: {},

			/* ==================== 树形结构和展开收起 ==================== */
			/** 展开的树节点ID集合 - 记录哪些上级节点处于展开状态 */
			opens: opens,
			/** 上级ID字段名 - 树形结构中的父级字段，默认'father_id' */
			father_id: "father_id",
			/** 表格的选中集合 - Element表格组件v-model绑定值 */
			selection: [],

			/* ==================== 权限和用户信息 ==================== */
			/** 登录权限配置 - signIn:是否需要登录，gm:管理员标记，user_admin:权限列表 */
			oauth: {
				"signIn": true,  // 是否要求登录
				"gm": 0,  // 0:普通用户，1:管理员
				"user_admin": []  // 用户拥有的权限列表
			},
			/** 当前登录用户 - 从Vuex store获取 */
			user: this.$store.state.user,
			/** 用户所属组 - 从Vuex store获取，用于权限判断 */
			user_group: this.$store.state.user.user_group,
			/** 是否显示修改提示 - true显示操作成功提示，false不显示 */
			tip_show: true,

		};
	},
	methods: {

		/**
		 * 事件管理 - 用于管理和触发各类事件钩子
		 * 支持调用组件内定义的任意方法
		 * 
		 * @param {String} name 事件名 - 对应组件中的方法名
		 * @param {Object} param1 参数1 - 第一个参数
		 * @param {Object} param2 参数2 - 第二个参数
		 * @param {Object} param3 参数3 - 第三个参数
		 * @return {Object} 返回事件特定值
		 */
		events: function events(name, param1, param2, param3) {
			if (this[name]) {
				if (param3) {
					return this[name](param1, param2, param3);
				} else {
					return this[name](param1, param2);
				}
			} else {
				return null;
			}
		},

		/**
		 * @description 添加数据
		 * @param {Object} param 要添加的数据
		 * @param {Function} func 回调函数
		 */
		add: function add(param, func) {
			if (!param) {
				param = this.obj;
			}
			var pm = this.events("add_before", Object.assign({}, param)) || param;
			var msg = this.events("add_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("add_main", pm, func);
			}
			return ret;
		},

		/**
		 * @description 删除数据
		 * @param {Object} param 查询条件
		 */
		del: function del(param, func) {
			if (!param) {
				param = this.query;
			}
			var pm = this.events("del_before", Object.assign({}, param)) || param;
			var msg = this.events("del_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("del_main", pm, func);
			}
			return ret;
		},

		del_show: function (o, id) {
			/**
			 * 显示删除确认对话框 - 用户确认后执行删除操作
			 * 
			 * @param {Object} o 要删除的对象
			 * @param {String} id 对象的主键字段名
			 */
			var _this = this;
			$.confirm('删除后将无法回复!<br/>是否确定要删除？', function () {
				// 构建删除条件，将主键字段和值组装成query对象
				var query = {};
				query[id] = o[id];
				_this.del(query, function () {
					_this.list.del(query);  // 从列表中移除该项
					_this.count -= 1;  // 更新查询结果总数
				});
			}, function () {
				// 取消删除操作
			})
		},

		/**
		 * @description 修改数据
		 * @param {Object} param 修改项
		 * @param {String} query 查询条件
		 * @param {Boolean} includeZero 是否包括0
		 */
		set: function set(param, query, func, includeZero) {
			if (!param) {
				param = this.obj;
			}
			if (query) {
				this.query_set = query;
			} else {
				this.query_set = Object.assign({}, this.query);
			}
			var pm = this.events("set_before", Object.assign({}, param), includeZero) || param;
			var msg = this.events("set_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("set_main", pm, func);
			}
			return ret;
		},

		/**
		 * 修改前事件
		 * @param {Object} param
		 * @param {Boolean} includeZero 是否删除0值项
		 * @param {Object} 返回新的参数
		 */
		set_before: function set_before(param, includeZero) {
			var pm = $.delete(param, includeZero);
			for (var k in pm) {
				if (k.toLocaleLowerCase().indexOf('time') !== -1 && pm[k].indexOf('T') !== -1) {
					pm[k] = new Date(pm[k]).toStr('yyyy-MM-dd 00:00:00');
				}
			}
			return pm;
		},

		/**
		 * 批量修改 - 对多个已选项进行相同的修改操作
		 * 
		 * 工作流程：
		 * 1. 显示确认对话框
		 * 2. 构建查询条件（合并原查询条件和修改条件）
		 * 3. 将选中的ID集合添加到查询条件中
		 * 4. 删除分页和排序参数
		 * 5. 执行修改操作
		 * 6. 成功后刷新列表
		 */
		batchSet: function batchSet() {
			var _this = this;
			$.confirm('批量修改数据无法挽回<br/>确定要操作吗?', function () {
				// 合并查询条件和修改条件
				var q = Object.assign({}, _this.query, _this.query_set);
				// 添加选中项ID集合
				q[_this.field] = _this.selects;
				// 删除分页和排序参数
				delete q.page;
				delete q.size;
				delete q.orderby;
				// 执行修改
				_this.set(_this.form, q, function (json) {
					if (json.result) {
						_this.show = false;  // 关闭对话框
						_this.get();  // 刷新列表
					}
				}, true);
			});
		},

		/**
		 * 查询多条数据 - 获取列表数据并支持分页、搜索、排序
		 * 
		 * 执行流程：
		 * 1. 触发get_list_before事件（在查询前可修改参数）
		 * 2. 触发get_list_check事件（验证查询条件是否合法）
		 * 3. 如果验证通过，触发get_list_main事件执行真实查询
		 * 
		 * @param {Object} query 查询条件 - 如果为空则使用this.query
		 * @param {Function} func 回调函数 - 查询完成后调用
		 * @return {Object} 返回事件处理结果
		 */
		get_list: function get_list(param, func) {
			if (!param) {
				param = this.query;
			}
			var pm = this.events("get_list_before", Object.assign({}, param)) || param;
			var msg = this.events("get_list_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("get_list_main", pm, func);
			}
			return ret;
		},

		/**
		 * 查询单条数据 - 获取指定对象的详细信息
		 * 
		 * 执行流程：
		 * 1. 触发get_obj_before事件
		 * 2. 触发get_obj_check事件进行验证
		 * 3. 如果验证通过，触发get_obj_main事件执行查询
		 * 4. 如果验证失败，直接回调func函数
		 * 
		 * @param {Object} query 查询条件 - 通常为{主键字段: 值}
		 * @param {Function} func 回调函数 - 查询完成或验证失败时调用
		 * @return {Object} 返回事件处理结果
		 */
		get_obj: function get_obj(param, func) {
			if (!param) {
				param = this.query;
			}
			var pm = this.events("get_obj_before", Object.assign({}, param)) || param;
			var msg = this.events("get_obj_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("get_obj_main", pm, func);
			} else if (func) {
				func();
			}
			return ret;
		},

		/**
		 * 条件排序 - 使用指定条件对数据进行排序
		 * 
		 * @param {Object} param 排序条件
		 * @param {Object} func 回调函数
		 */
		sort: function sort(param, func) {
			var pm = this.events("sort_before", Object.assign({}, param)) || param;
			var msg = this.events("sort_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("sort_main", pm, func);
			}
			return ret;
		},

		/**
		 * 权限检查 - 检测授权，有权限后回调函数
		 * 
		 * 检查流程：
		 * 1. 检查是否需要登录(oauth.signIn)
		 * 2. 如果需要登录，检查用户是否已登录
		 * 3. 如果未登录，获取用户信息后再回调
		 * 4. 如果不需要登录，直接回调
		 * 
		 * @param {Function} func 权限验证通过后的回调函数
		 */
		check_auth: function check_auth(func) {
			if (this.oauth.signIn) {
				if (this.user.user_id) {
					// 用户已登录，直接执行回调
					func();
				} else {
					// 用户未登录，先获取用户信息
					this.$get_user(func);
				}
			} else {
				// 不需要登录，直接执行回调
				func();
			}
		},

		/**
		 * 初始化组件 - 组件created时自动调用
		 * 
		 * 初始化流程：
		 * 1. 触发init_before事件（在初始化前处理参数）
		 * 2. 触发init_check事件（验证初始化条件）
		 * 3. 如果验证通过，触发init_main事件执行初始化逻辑
		 * 4. 如果验证失败，直接回调func函数
		 * 
		 * @param {Object} param 初始化参数 - 通常为路由query参数
		 * @param {Function} func 初始化完成回调函数
		 * @return {Object} 返回事件处理结果
		 */
		init: function init(param, func) {
			var pm = this.events("init_before", Object.assign({}, param)) || param;
			var msg = this.events("init_check", pm);
			var ret;
			if (!msg) {
				ret = this.events("init_main", pm, func);
			} else if (func) {
				func();
			}
			return ret;
		},

		/**
		 * 文件上传 - 上传文件到服务器
		 * 
		 * 上传流程：
		 * 1. 触发upload_before事件
		 * 2. 触发upload_check事件进行验证
		 * 3. 如果验证失败，显示错误提示
		 * 4. 如果验证通过，触发upload_main事件执行上传
		 * 
		 * @param {Object} param 上传参数 - 包含文件和其他元数据
		 * @param {Function} func 上传完成回调函数
		 * @return {Object} 返回事件处理结果
		 */
		upload: function upload(param, func) {
			var pm = this.events("upload_before", Object.assign({}, param)) || param;
			var msg = this.events("upload_check", pm);
			var ret;
			if (msg) {
				this.$toast(msg, 'danger');
			} else {
				ret = this.events("upload_main", pm, func);
			}
			return ret;
		},

		/**
		 * 添加数据(实际执行) - 将新数据提交到服务器
		 * 
		 * 工作流程：
		 * 1. 确定API地址（优先使用url_add，否则使用url + "method=add"）
		 * 2. 发送POST请求
		 * 3. 解析响应数据
		 * 4. 触发add_after事件（可自定义处理结果）
		 * 5. 根据结果显示成功或错误提示
		 * 
		 * @param {Object} value 要添加的数据对象
		 * @param {Function} func 添加完成回调函数
		 */
		add_main: function add_main(value, func) {
			var url = this.url ? this.url + "method=add" : this.url_add;
			if (!url) {
				return;
			}
			var _this = this;
			this.$post(url, value, function (json) {
				_this.events("add_after", json, func);
				if (json.result) {
					_this.$toast(json.result.tip, json.result.bl ? 'success' : 'danger');
				} else if (json.error) {
					_this.$toast(json.error.message, 'danger');
				} else {
					_this.$toast('添加失败! 原因:是服务器连接失败!', "danger");
				}
			});
		},

		/**
		 * 删除数据(实际执行) - 从服务器删除指定数据
		 * 
		 * 工作流程：
		 * 1. 确定API地址（优先使用url_del）
		 * 2. 发送GET请求并传入删除条件
		 * 3. 触发del_after事件处理响应
		 * 4. 根据结果显示成功或错误提示
		 * 
		 * @param {Object} query 删除条件 - 通常为{主键字段: 值}
		 * @param {Function} func 删除完成回调函数
		 */
		del_main: function del_main(query, func) {
			var url = this.url ? this.url + "method=del" : this.url_del;
			if (!url) {
				return;
			}
			var _this = this;
			this.$get(url, query, function (json) {
				_this.events("del_after", json, func);
				if (json.result) {
					_this.$toast(json.result.tip, json.result.bl ? 'success' : 'danger');
				} else if (json.error) {
					_this.$toast(json.error.message, 'danger');
				} else {
					_this.$toast('删除失败! 原因:是服务器连接失败!', "danger");
				}
			});
		},

		/**
		 * 删除之后事件
		 * @param {Object} json 返回的结果
		 * @param {Object} func 回调函数
		 */
		del_after: function del_after(json, func) {
			if (func) {
				func();
			}
		},

		/**
		 * 修改数据(实际执行) - 将修改后的数据提交到服务器
		 * 
		 * 工作流程：
		 * 1. 确定API地址（优先使用url_set）
		 * 2. 如果未设置query_set，使用原查询条件
		 * 3. 将修改条件拼接到URL中
		 * 4. 发送POST请求
		 * 5. 触发set_after事件处理响应
		 * 6. 显示成功或错误提示
		 * 
		 * @param {Object} value 修改的数据
		 * @param {Function} func 修改完成回调函数
		 */
		set_main: function set_main(value, func) {
			var url = this.url ? this.url + "method=set" : this.url_set;
			if (!url) {
				return;
			}
			var _this = this;
			if (!this.query_set || Object.keys(this.query_set).length === 0) {
				this.query_set = this.query;
			}
			this.$post(this.toUrl(this.query_set, url), value, function (json, status) {
				_this.events("set_after", json, func);
				if (json.result) {
					if (json.result.bl) {
						if (_this.tip_show) {
							_this.$toast(json.result.tip.replace('修改', '更新'), "success");
						}
					} else {
						_this.$toast(json.result.tip.replace('修改', '更新'), "danger");
					}
				} else if (json.error) {
					_this.$toast(json.error.message, "danger");
				} else {
					_this.$toast('修改失败! 原因:是服务器连接失败!', "danger");
				}
			});
		},

		/**
		 * 修改成功时执行
		 * @param {Object} json 结果
		 * @param {Object} func 回调函数
		 */
		set_after: function set_after(json, func) {
			if (func) {
				func(json);
			}
		},

		/**
		 * 查询数据 - 高层调用，支持查询对象或列表
		 * 
		 * @param {Object} query 查询参数
		 * @param {Function} func 回调函数
		 */
		get: function get(query, func) {
			this.get_main(query, func);
		},

		/**
		 * 查询数据(实际执行) - 先查询单个对象，再创建完整列表
		 * 
		 * 工作流程：
		 * 1. 确定API地址（优先使用url_get_obj）
		 * 2. 如果设置了API地址，先调用get_obj查询单个对象
		 * 3. 查询完成后调用get_create构建完整数据
		 * 4. 如果未设置API地址，直接调用get_create
		 * 
		 * @param {Object} query 查询参数
		 * @param {Function} func 回调函数
		 */
		get_main: function get_main(query, func) {
			var url = this.url_get_obj ? this.url_get_obj : this.url;
			if (url) {
				var _this = this;
				this.get_obj(query, function () {
					_this.get_create(query, func);
				});
			} else {
				this.get_create(query, func);
			}
		},

		/**
		 * 查询单条数据验证 - 检查查询条件是否有效
		 * 
		 * 验证规则：至少有一个非空的查询条件
		 * 
		 * @param {Object} param 查询参数
		 * @return {String} 如果验证失败返回错误信息，否则返回null
		 */
		get_obj_check: function get_obj_check(param) {
			var bl = false;
			for (var k in param) {
				if (param[k]) {
					bl = true;
					break;
				};
			}
			if (bl) {
				return null;  // 验证通过
			} else {
				return "缺少查询条件";  // 验证失败
			}
		},

		/**
		 * 查询单条数据(实际执行) - 从服务器获取指定对象信息
		 * 
		 * 工作流程：
		 * 1. 确定API地址
		 * 2. 将查询条件拼接到URL中
		 * 3. 发送GET请求
		 * 4. 解析响应数据（支持obj、list两种格式）
		 * 5. 将查询结果保存到this.obj
		 * 6. 触发get_obj_after事件
		 * 
		 * @param {Object} query 查询条件
		 * @param {Function} func 查询完成回调函数
		 */
		get_obj_main: function get_obj_main(query, func) {
			var url = this.url_get_obj ? this.url_get_obj : this.url + "method=get_obj";
			if (!url) {
				return;
			}
			var _this = this;
			this.$get(this.toUrl(query, url), null, function (json, status) {
				_this.events("get_obj_after", json, func);
				var res = json.result;
				if (res) {
					var obj;
					if (res.obj) {
						obj = res.obj;
						delete res.obj;
					} else {
						var list = res.list;
						if (list && list.length > 0) {
							obj = list[0];
						} else {
							obj = res;
						}
					}
					if (obj) {
						if (_this.obj || Object.keys(_this.obj).length === 0) {
							_this.obj = obj;
						} else {
							$.push(_this.obj, obj);
						}
						var o = _this.obj;
						for (var k in o) {
							if (k.indexOf('time') !== -1) {
								var val = o[k];
								if (val && val.indexOf('T') !== -1) {
									var v = new Date(o[k]);
									o[k] = v.toStr('yyyy-MM-dd hh:mm:ss');
								}
							}
						}
						if (_this.form || Object.keys(_this.form).length === 0) {
							_this.form = Object.assign({}, _this.obj)
						} else {
							$.push(_this.form, Object.assign({}, _this.obj));
						}
					}
				} else if (json.error) {
					console.log(json.error.message);
				} else {
					_this.$toast("服务器连接失败！", "danger");
				}
			});
		},

		/**
		 * @description 获取到对象后事件
		 * @param {Object} json 响应结果
		 */
		get_obj_after: function get_obj_after(json, func) {
			if (func) {
				func(json);
			}
		},

		/**
		 * 查询多条数据(实际执行) - 从服务器获取列表数据
		 * 
		 * 工作流程：
		 * 1. 确定API地址（优先使用url_get_list）
		 * 2. 将查询条件拼接到URL中
		 * 3. 显示加载进度(loading = 0)
		 * 4. 发送GET请求
		 * 5. 隐藏加载进度(loading = 100)
		 * 6. 根据clear_list决定是否清空原列表
		 * 7. 触发get_list_after事件
		 * 8. 解析响应数据并添加到list中
		 * 
		 * @param {Object} query 查询条件 - 包含page、size等分页信息
		 * @param {Function} func 查询完成回调函数
		 */
		get_list_main: function get_list_main(query, func) {
			var url = this.url_get_list ? this.url_get_list : this.url;
			if (!url) {
				return;
			}
			var _this = this;
			this.loading = 0;  // 开始加载
			this.$get(this.toUrl(query, url), null, function (json, status) {
				_this.loading = 100;  // 加载完成
				if (_this.clear_list) {
					_this.list.clear();  // 清空原列表
				}
				_this.events("get_list_after", json, func, url);
				var res = json.result;
				if (res) {
					_this.page_now = _this.query.page;
					_this.list.addList(res.list);  // 添加新数据
					if (res.count !== undefined) {
						_this.count = res.count;  // 更新总数
					}
				} else if (json.error) {
					console.log(json.error.message);
				} else {
					_this.$toast("服务器连接失败！", "danger");
				}
			});
		},

		/**
		 * @description 获取到列表事件
		 * @param {Object} res 响应结果
		 */
		get_list_after: function get_list_after(res, func, url) {
			if (func) {
				func(res, url);
			}
		},

		/**
		 * 搜索 - 搜索+重置到首页
		 * 
		 * 工作流程：
		 * 1. 合并新的查询条件
		 * 2. 将分页重置为第一页
		 * 3. 重置查询结果总数为0
		 * 4. 更新URL显示当前查询条件
		 * 5. 调用first()方法执行查询
		 * 
		 * @param {Object} query 新的查询条件
		 * @param {Function} func 查询完成回调函数
		 */
		search: function search(query, func) {
			if (query) {
				$.push(this.query, query);  // 合并查询条件
			}
			var url = this.url_get_list ? this.url_get_list : this.url;
			if (url) {
				this.query.page = 1;  // 重置到首页
				this.count = 0;  // 重置总数
				$.route.push("?" + this.toUrl(this.query));  // 更新URL
				this.first(query, func);  // 执行查询
			}
		},

		/**
		 * 获取/创建 - 根据查询条件创建或查询数据
		 * 
		 * @param {Object} query 查询条件
		 * @param {Function} func 回调函数
		 */
		get_create: function get_create(query, func) {
			if (query) {
				$.push(this.query, query);  // 合并查询条件
			}
			var url = this.url_get_list ? this.url_get_list : this.url;
			if (url) {
				this.count = 0;
				$.route.push("?" + this.toUrl(this.query));  // 更新URL
				this.first(query, func);  // 查询列表
			}
		},

		/**
		 * 首页查询 - 查询第一页的数据
		 * 
		 * 工作流程：
		 * 1. 如果count为0（第一次查询），使用当前query重新查询
		 * 2. 否则使用提供的query查询
		 * 
		 * @param {Object} query 查询条件
		 * @param {Function} func 查询完成回调函数
		 */
		first: function first(query, func) {
			var _this = this;
			if (!this.count) {
				var qy = Object.assign({}, this.query);
				this.get_list(qy, func);
			} else {
				this.get_list(query, func);
			}
		},

		/**
		 * 下一页 - 查询下一页的数据
		 * 
		 * 工作流程：
		 * 1. 调用get_list获取当前页数据
		 * 2. 如果返回数据非空，构建下一页的query(page+1)
		 * 3. 检查下一页号是否超出总页数
		 * 4. 如果未超出，发送下一页查询请求
		 * 5. 回调func函数
		 * 
		 * @param {Object} query 当前查询条件
		 * @param {Function} func 查询完成回调函数
		 */
		next: function next(query, func) {
			var _this = this;
			this.get_list(query, function (json, url) {
				if (json.result) {
					var list = json.result.list;
					if (list.length > 0) {
						var qy = Object.assign({}, query, {
							page: query.page + 1
						});
						if (qy.page <= _this.page_count) {  // 检查是否超出总页数
							_this.$get(_this.toUrl(qy, url));
						}
					}
				}
				if (func) {
					func(json);
				}
			});
		},

		/**
		 * 上一页 - 查询上一页的数据
		 * 
		 * 工作流程：
		 * 1. 调用get_list获取当前页数据
		 * 2. 如果返回数据非空，构建上一页的query(page-1)
		 * 3. 检查上一页号是否小于1
		 * 4. 如果未小于1，发送上一页查询请求
		 * 5. 回调func函数
		 * 
		 * @param {Object} query 当前查询条件
		 * @param {Function} func 查询完成回调函数
		 */
		prev: function prev(query, func) {
			var _this = this;
			this.get_list(query, function (json, url) {
				if (json.result) {
					var list = json.result.list;
					if (list.length > 0) {
						var qy = Object.assign({}, query, {
							page: query.page - 1
						});
						if (qy.page >= 1) {  // 检查是否小于1
							_this.$get(_this.toUrl(qy, url));
						}
					}
				}
				if (func) {
					func(json);
				}
			});
		},

		/**
		 * 清除数据 - 清除对象中的所有值
		 * 
		 * @param {Object} query 要清除的对象
		 */
		clear: function clear(query) {
			$.clear(query);  // 清除query对象中的所有字段
		},

		/**
		 * 重置 - 重置查询条件到初始状态
		 * 
		 * 工作流程：
		 * 1. 清除当前查询条件
		 * 2. 使用config(初始配置)重新初始化查询条件
		 * 3. 重新查询列表
		 */
		reset: function reset() {
			$.clear(this.query);  // 清除所有查询条件
			$.push(this.query, this.config);  // 恢复初始配置
			this.get_list();  // 重新查询
		},

		/**
		 * 表单提交(UI触发) - 提交前先通过Element表单验证
		 * 
		 * 工作流程：
		 * 1. 调用Element表单的validate方法验证字段
		 * 2. 验证通过则调用submit()
		 * 3. 验证失败则输出错误消息
		 */
		submitForm() {
			this.$refs["form"].validate((valid) => {
				if (valid) {
					this.submit();  // 表单验证通过，执行提交
				} else {
					console.error('error 提交失败!!');  // 表单验证失败
				}
			});
		},

		/**
		 * 提交事件 - 支持事件钩子机制的表单提交
		 * 
		 * 执行流程：
		 * 1. 使用提供的param或默认的this.form
		 * 2. 触发submit_before事件（允许修改参数）
		 * 3. 触发submit_check事件（验证参数合法性）
		 * 4. 如果验证失败，显示错误提示
		 * 5. 如果验证通过，触发submit_main事件执行真实提交
		 * 
		 * @param {Object} param 提交的表单数据
		 * @param {Function} func 提交完成回调函数
		 * @return {Object} 返回事件处理结果
		 */
		submit: function submit(param, func) {
			if (!param) {
				param = this.form;  // 使用默认form数据
			}
			var pm = this.events("submit_before", Object.assign({}, param)) || param;
			var msg = this.events("submit_check", pm);
			var ret;
			if (msg) {
				this.$toast(msg, 'danger');  // 验证失败，显示错误提示
			} else {
				ret = this.events("submit_main", pm, func);  // 验证通过，执行提交
			}
			return ret;
		},

		/**
		 * 提交前事件 - 在提交前允许修改表单参数
		 * 
		 * @param {Object} param 提交参数
		 * @return {Object} 返回修改后的参数
		 */
		submit_before: function (param) {
			return param;
		},

		/**
		 * 提交前验证事件 - 检查表单参数是否合法
		 * 
		 * @param {Object} param 请求参数
		 * @return {String} 验证成功返回null, 失败返回错误提示信息
		 */
		submit_check: function submit_check(param) {
			// 可在子组件中override此方法进行自定义验证
			return null;
		},

		/**
		 * 提交表单(实际执行) - 将表单数据提交到服务器
		 * 
		 * 工作流程：
		 * 1. 根据form中是否有ID字段来判断是add还是set操作
		 * 2. 优先使用url_submit，否则根据有无ID判断使用url_add或url_set
		 * 3. 将当前查询条件拼接到URL中
		 * 4. 发送POST请求
		 * 5. 根据返回结果显示成功或失败提示
		 * 6. 触发submit_after事件并返回上一页
		 * 
		 * @param {Object} param 提交的表单数据
		 * @param {Function} func 提交完成回调函数
		 */
		submit_main: function submit_main(param, func) {
			var url = this.url;
			if (url) {
				if (this.field) {
					var id = param[this.field];
					if (id) {
						// 有ID则执行修改操作
						var q = {
							method: 'set'
						};
						q[this.field] = id;
						url = this.toUrl(q, url);
					} else {
						// 无ID则执行添加操作
						url += "method=add"
					}
				} else {
					url += "method=submit"
				}
			} else if (this.url_submit) {
				url = this.url_submit;
			} else if (this.field) {
				var id = param[this.field];
				if (id) {
					url = this.url_set;
				} else {
					url = this.url_add;
				}
			}

			if (url) {
				var _this = this;
				url = this.$toUrl(this.query, url);
				this.$post(url, param, function (json, status) {
					if (json.result) {
						_this.$toast('提交成功！', 'success');
						_this.events("submit_after", json, func);
					} else if (json.error) {
						_this.$toast(json.error.message, 'danger');
					} else {
						_this.$toast("服务器连接失败！", "danger");
					}
				});
			}
		},

		/**
		 * 提交后事件 - 提交成功后的处理，默认返回上一页
		 * 
		 * @param {Object} json 服务器返回结果
		 * @param {Function} func 回调函数
		 */
		submit_after: function submit_after(json, func) {
			if (func) {
				func(json);
			}
			this.$router.go(-1);  // 返回上一页
		},

		/**
		 * 翻页 - 相对当前页向前或向后翻
		 * 
		 * @param {Number} n 页码偏移量 - 正数向后翻，负数向前翻
		 */
		go: function go(n) {
			var page = this.query.page + n;
			this.goTo(page);
		},

		/**
		 * 跳转到指定页 - 验证页码合法性后执行跳转
		 * 
		 * 工作流程：
		 * 1. 验证页码范围（最小1，最大总页数）
		 * 2. 更新URL显示新的page参数
		 * 3. 根据跳转距离选择合适的查询方法：
		 *    - 下一页：调用next()
		 *    - 上一页：调用prev()
		 *    - 其他距离：调用first()
		 * 4. 如果总页数为0，直接调用first()
		 * 
		 * @param {Number} page 目标页码
		 */
		goTo: function goTo(page) {
			// 验证页码范围
			if (page < 1) {
				page = 1;
			} else if (page > this.page_count) {
				page = this.page_count;
			}
			var query = this.query;
			var p = query.page;
			query.page = page;
			this.$router.push("?" + this.toUrl(query));  // 更新URL
			if (this.page_count !== 0) {
				if (p + 1 == page) {
					this.next(query);  // 下一页
				} else if (p - 1 == page) {
					this.prev(query);  // 上一页
				} else {
					this.first(query);  // 其他页
				}
			} else {
				this.first(query);
			}
		},

		/**
		 * 转换URL - 将对象转换为URL查询字符串
		 * 
		 * 使用说明：
		 * 将{a:1, b:2}转换为"?a=1&b=2"格式
		 * 
		 * @param {Object} obj 要转换的对象
		 * @param {String} url 基础URL
		 * @return {String} 返回完整的URL字符串
		 */
		toUrl: function toUrl(obj, url) {
			return $.toUrl(obj, url);
		},

		/**
		 * 初始化前 - 在init_main前执行，可修改初始查询条件
		 * 
		 * @param {Object} query 初始查询条件
		 * @return {Object} 返回修改后的查询条件
		 */
		init_before: function init_before(query) {
			if (!query) {
				query = this.config;  // 使用默认配置
			}
			return query;
		},

		/**
		 * 初始化(实际执行) - 初始化组件并执行第一次查询
		 * 
		 * @param {Object} query 初始查询条件
		 */
		init_main: function init_main(query) {
			var _this = this;
			$.push(this.query, query);  // 合并初始查询条件
			_this.init_after(function () {
				_this.get(_this.query);  // 执行第一次查询
			});
		},

		/**
		 * 初始化后 - 在init_main之后执行
		 * 
		 * @param {Function} func 后续处理回调
		 */
		init_after: function init_after(func) {
			if (func) {
				func();
			}
		},

		/**
		 * 上传文件(实际执行) - 将文件上传到服务器
		 * 
		 * 工作流程：
		 * 1. 确定上传API地址
		 * 2. 设置uploading = 0表示上传开始
		 * 3. 发送文件上传请求(使用FormData格式)
		 * 4. 设置uploading = 100表示上传完成
		 * 5. 触发upload_after事件处理结果
		 * 
		 * @param {Function} func 上传完成回调函数
		 */
		upload_main: function upload_main(func) {
			var url = "";
			if (this.url) {
				url = this.url + "method=upload";
			} else {
				url = this.url_upload;
			}

			if (!param) {
				param = this.form;
			}
			if (msg) {
				this.$toast(msg, 'danger');
			} else {
				this.uploading = 0;  // 标记上传开始
				var _this = this;
				this.$upload(url, param, function (json, status) {
					_this.uploading = 100;  // 标记上传完成
					_this.events("upload_after", json, func);
				});
			}
		},

		/**
		 * 上传完成后事件 - 处理上传结果并显示提示信息
		 * 
		 * @param {Object} json 服务器返回的响应结果
		 * @param {Function} func 回调函数
		 */
		upload_after: function upload_after(json, func) {
			if (json.result) {
				this.$toast(json.result.tip, json.result.bl ? 'success' : 'danger');
			} else if (json.error) {
				this.$toast(json.error.message, 'danger');
			} else {
				this.$toast("服务器连接失败！", "danger");
			}
			if (func) {
				func();
			}
		},

		/**
		 * 组件销毁前事件 - 清理资源，可重写此方法进行自定义清理
		 * 
		 * @param {Object} param 参数
		 */
		end_before: function end_before(param) {
			// 例：this.reset();  // 重置查询条件
		},

		/**
		 * 全选/取消全选 - 切换列表中所有项目的选中状态
		 * 
		 * 工作流程：
		 * 1. 反转select_state标志
		 * 2. 如果取消全选(bl=false)，清空selects
		 * 3. 如果全选(bl=true)，将列表中所有项ID添加到selects
		 * 4. 使用'|'作为分隔符
		 */
		select_all: function select_all() {
			var bl = !this.select_state;  // 反转状态
			if (!bl) {
				this.selects = '';  // 取消全选，清空
			} else {
				var s = '';
				var list = this.list;
				// 遍历列表，将所有项ID连接
				for (var i = 0; i < list.length; i++) {
					s += '|' + list[i][this.field];
				}
				this.selects = s.replace('|', '');  // 移除第一个'|'
			}
			this.select_state = bl;
		},

		/**
		 * 切换单个项的选择状态 - 添加或删除指定ID
		 * 
		 * 工作流程：
		 * 1. 将selects字符串按'|'分割成数组
		 * 2. 检查ID是否已在数组中
		 * 3. 已有则删除(取消选择)，否则添加(选择)
		 * 4. 重新连接为selects字符串
		 * 
		 * @param {String|Number} id 要切换的项目ID
		 */
		select_change: function select_change(id) {
			var has = false
			var arr = this.selects.split('|');
			for (var i = 0; i < arr.length; i++) {
				var o = arr[i];
				if (id == o) {
					arr.splice(i, 1);  // 删除该ID
					has = true;
					break;
				}
			}
			if (!has) {
				arr.push(id)  // 添加该ID
			}
			var s = arr.join('|');
			if (s.indexOf('|') == 0) {
				this.selects = s.substring(1)  // 移除首个'|'
			} else {
				this.selects = s;
			}
		},

		/**
		 * 判断ID是否已选 - 检查指定ID是否在selects中
		 * 
		 * 使用'|'作为分隔符来精确匹配ID，避免子串匹配的问题
		 * 例：selects='1|23|4'，判断'2'时应返回false，而不是true
		 * 
		 * @param {String|Number} id 要判断的项目ID
		 * @return {Boolean} true表示已选，false表示未选
		 */
		select_has: function select_has(id) {
			var ids = '|' + this.selects + '|';
			return ids.indexOf('|' + id + '|') !== -1;
		},

		/**
		 * 标记某项为已选 - 保存选择状态到localStorage
		 * 
		 * @param {Number} index 列表中的项目索引
		 */
		selected: function selected(index) {
			this.select = index;  // 更新选中索引
			$.db.set('select', index, 120);  // 保存到本地存储，过期时间120秒
		},

		/**
		 * 页码改变时触发 - 当用户在页码输入框输入时调用
		 * 
		 * 工作流程：
		 * 1. 获取输入的页码值
		 * 2. 验证页码是否为有效的数字
		 * 3. 验证页码范围(最小1，最大总页数)
		 * 4. 更新page_now为新的页码
		 * 
		 * @param {Object} e 输入框事件对象
		 */
		page_change: function page_change(e) {
			var n = Number(e.target.value);
			if (isNaN(n)) {
				n = 1;  // 非数字则默认为1
			}
			if (n < 1) {
				n = 1;  // 小于1则为1
			} else if (n > this.page_count) {
				n = this.page_count  // 超过总页数则为最后一页
			}
			this.page_now = n;
		},

		/**
		 * 获取名称 - 从列表中根据ID查找对应的名称
		 * 
		 * 支持两种模式：
		 * 1. 单个ID：直接查找对应的name字段值
		 * 2. 多个ID(用span分隔)：查找所有匹配ID的name，用'|'连接
		 * 
		 * @param {Array} list 数据列表
		 * @param {String|Number} arr_str ID或ID集合字符串
		 * @param {String} key 列表中的主键字段名
		 * @param {String} name 列表中的名称字段名(默认"name")
		 * @param {String} span 多个ID的分隔符(默认",")
		 * @return {String} 返回对应的名称，多个名称用','分隔
		 */
		get_name(list, arr_str, key, name, span) {
			if (!name) {
				name = "name";  // 默认字段名
			}
			var value = "";
			if (arr_str) {
				if (typeof (arr_str) == 'string') {
					if (!span) {
						span = ',';  // 默认分隔符
					}
					var arr = arr_str.split(span);
					var id = Number(arr[0]);

					for (var i = 0; i < list.length; i++) {
						var o = list[i];
						if (o[key] == id) {
							value += '|' + o[name];
						}
					}
				} else {
					var id = arr_str;
					for (var i = 0; i < list.length; i++) {
						var o = list[i];
						if (o[key] == id) {
							value = o[name];
							break
						}
					}
				}
			}
			return value.replace('|', '');
		},

		/**
		 * 取消并返回 - 返回到前一个页面
		 */
		cancel: function cancel() {
			this.$router.go(-1);  // 返回上一页
		},

		/**
		 * 导入数据 - 从文件导入数据到系统
		 * 
		 * 工作流程：
		 * 1. 显示确认对话框，显示文件名
		 * 2. 用户确认后上传文件到url_import
		 * 3. 服务器处理导入，返回导入结果
		 * 4. 显示导入结果，确认后刷新列表
		 * 
		 * @param {Object} file 要导入的文件对象
		 */
		import_db: function import_db(file) {
			if (file) {
				var _this = this;
				$.confirm("是否导入 " + file.name, "导入数据", function () {
					$.http.upload(_this.url_import, file, function (json) {
						if (json.result) {
							$.confirm(json.result.tip, function () {
								_this.get();  // 导入完成后刷新列表
							});
						} else if (json.error) {
							$.confirm(json.error.message);
						} else {
							_this.$toast("服务器连接失败！", "danger");
						}
					});
				});
			}
		},

		/**
		 * 导出数据 - 导出选中的数据或所有数据为Excel文件
		 * 
		 * 工作流程：
		 * 1. 如果有选中项(selects不为空)，只导出选中数据
		 * 2. 否则导出当前查询条件下的所有数据
		 * 3. 服务器返回下载链接
		 * 4. 浏览器直接下载文件
		 */
		export_db: function export_db() {
			var _this = this;
			if (this.selects) {
				// 导出已选中的数据
				var query = {};
				query[this.field] = this.selects;
				this.$get(_this.url_export, query, function (json) {
					var res = json.result;
					if (res && res.bl) {
						window.location.href = res.url;  // 下载文件
					}
				});
			} else {
				// 导出当前查询结果的所有数据
				this.$get(_this.url_export, this.query, function (json) {
					var res = json.result;
					if (res && res.bl) {
						window.location.href = res.url;  // 下载文件
					}
				});
			}
		},

		/**
		 * 判断是否有下级 - 检查某个节点是否有子节点
		 * 
		 * 用于树形结构中判断是否可以展开
		 * 
		 * @param {Number} id 要检查的节点ID
		 * @param {Object} list 数据列表(默认使用this.list)
		 * @return {Boolean} true表示有子节点，false表示没有
		 */
		opens_has_sub: function (id, list) {
			if (!list) {
				list = this.list;
			}
			var bl = false;
			var father_id = this.father_id;  // 父级ID字段名
			for (var i = 0; i < list.length; i++) {
				var o = list[i];
				if (o[father_id] === id) {
					bl = true;
					break;
				}
			}
			return bl;
		},

		/**
		 * 切换展开状态 - 展开或收起树节点
		 * 
		 * @param {Number} id 节点ID
		 */
		/**
		 * 切换展开状态 - 展开或收起树节点
		 * 
		 * 工作流程：
		 * 1. 检查节点ID是否已在opens数组中
		 * 2. 如果已存在，从数组中移除(收起)
		 * 3. 如果不存在，检查是否有子节点
		 * 4. 有子节点则添加到opens数组(展开)
		 * 5. 将opens状态保存到localStorage
		 * 
		 * @param {Number} id 节点ID
		 */
		opens_change: function opens_change(id) {
			var index = this.opens.indexOf(id);
			if (index !== -1) {
				this.opens.splice(index, 1);  // 收起：移除该节点
			} else {
				var bl = this.opens_has_sub(id);
				if (bl) {
					this.opens.push(id);  // 展开：添加该节点
				}
			}
			$.db.set('opens', this.opens);  // 保存状态
		},

		/**
		 * 判断节点是否已展开 - 检查ID是否在opens数组中
		 * 
		 * @param {Number} id 节点ID
		 * @return {Boolean} true表示已展开，false表示已收起
		 */
		opens_has: function opens_has(id) {
			return this.opens.indexOf(id) !== -1;
		},

		/**
		 * 计算节点层级 - 从祖先到该节点的深度
		 * 
		 * 工作流程：
		 * 1. 从给定的节点ID开始
		 * 2. 逐级查找其父节点(通过father_id字段)
		 * 3. 每找到一个父节点，级别加1
		 * 4. 直到找到根节点(father_id=0)或超过最大5级
		 * 
		 * @param {Number} fid 起始节点ID
		 * @param {Object} list 数据列表(默认使用this.list)
		 * @return {Number} 返回节点层级(0表示根节点)
		 */
		opens_lv: function opens_lv(fid, list) {
			if (!list) {
				list = this.list;
			}
			var lv = 0;
			var father_id = this.father_id;
			var id = this.field;
			var num = fid;
			for (var n = 0; n < 5; n++) {  // 最多查找5级
				if (num === 0) {
					break;
				}
				for (var i = 0; i < list.length; i++) {
					var o = list[i];
					if (o[id] === num) {
						lv++;
						num = o[father_id];
						if (num === 0) {
							break;
						}
					}
				}
			}
			return lv;
		},

		/**
		 * 筛选内容 - 用于表格列的筛选方法(与Element表格过滤器配合使用)
		 * 
		 * @param {Object} value 筛选值
		 * @param {Object} row 当前行数据
		 * @return {Boolean} true表示该行匹配筛选条件
		 */
		filterState(value, row) {
			return row.state === value;
		},

		/**
		 * 删除选中信息 - 删除Element表格中选中的所有项
		 * 
		 * 工作流程：
		 * 1. 检查是否有选中项(selection数组)
		 * 2. 如果未选中，显示提示信息
		 * 3. 如果已选中，显示删除确认对话框
		 * 4. 用户确认后执行删除操作
		 */
		delInfo() {
			var list = this.selection;
			if (list.length === 0) {
				this.$message({
					type: 'info',
					message: '选择对象不能为空!'
				});
				return;
			}
			this.$confirm('此操作将永久删除该文件, 是否继续？', '提示', {
				confirmButtonText: '确定',
				cancelButtonText: '取消',
				type: 'warning'
			}).then(async () => {
				console.log("进入");
				await this.delAll(list);
			}).catch(() => {
				this.$message({
					type: 'info',
					message: '已取消删除'
				});
			});
		},

		/**
		 * 批量删除 - 删除多个选中的项目
		 * 
		 * 工作流程：
		 * 1. 遍历删除对象列表
		 * 2. 对每个对象发送DELETE请求
		 * 3. 如果删除失败，中断删除，显示错误信息
		 * 4. 全部删除成功后，刷新列表
		 * 
		 * @param {Array} list 要删除的对象集合
		 */
		async delAll(list) {
			var bl = false;
			for (var i = 0; i < list.length; i++) {
				var o = await this.$get("~/api/user/del?", {
					user_id: list[i].user_id
				});
				if (o.error) {
					this.$message.error('删除失败' + o.error.message);
					break;  // 删除失败，中断
				} else {
					bl = true;
				}
			}
			if (bl) {
				this.$message({
					type: 'success',
					message: '删除成功!'
				});
				this.get_list()  // 刷新列表
			}
		},

		/**
		 * 上传文件 - 上传单个文件到服务器并保存URL到form中
		 * 
		 * 工作流程：
		 * 1. 创建FormData对象
		 * 2. 添加文件到FormData
		 * 3. 发送文件上传请求
		 * 4. 上传成功后，将返回的URL保存到form对象的指定字段
		 * 5. 上传失败则显示错误提示
		 * 
		 * @param {Object} file 文件对象(来自文件输入框)
		 * @param {String} key 保存到form的字段名(默认"img")
		 */
		uploadFile(file, key = "img") {
			var _this = this;
			var form = new FormData() // FormData 对象
			form.append('file', file) // 添加文件
			this.$upload(this.url_upload, form, function (json) {
				if (json.result) {
					// 上传成功，保存完整URL到form
					_this.form[key] = _this.$fullUrl("~" + json.result.url);
				} else {
					_this.$toast('上传失败！');
				}
			});
		},

		/**
		 * 表格选择改变 - Element表格选择变化时触发
		 * 
		 * @param {Array} val 选中行数据数组
		 */
		selectionChange(val) {
			this.selection = val;  // 保存选中行
		},

		/**
		 * 每页条数改变 - Element表格分页中改变每页显示条数时触发
		 * 
		 * 工作流程：
		 * 1. 更新query.size为新的条数值
		 * 2. 重新查询列表(默认回到首页)
		 * 
		 * @param {Number} size 新的每页条数
		 */
		handleSizeChange(size) {
			this.query.size = size;
			this.get_list();  // 刷新列表
		},

		/**
		 * 当前页改变 - Element表格分页中改变当前页时触发
		 * 
		 * 工作流程：
		 * 1. 更新query.page为新的页码
		 * 2. 重新查询该页的数据
		 * 
		 * @param {Number} page 新的页码
		 */
		handleCurrentChange(page) {
			this.query.page = page;
			this.get_list();  // 查询该页数据
		},

	},
	/* ==================== 计算属性 ==================== */
	computed: {
		/**
		 * 计算总页数
		 * 根据查询结果总数和每页大小计算总页数
		 * 公式：总页数 = 向上取整(总数 / 每页大小)
		 * 
		 * @return {Number} 总页数
		 */
		page_count: function page_count() {
			return Math.ceil(this.count / this.query.size);
		}
	},
	/* ==================== Vue生命周期钩子 ==================== */
	/**
	 * 组件创建完成时触发
	 * 初始化组件数据，从路由query参数获取初始查询条件
	 * 此时DOM还未挂载，showing设为0表示加载中
	 */
	created: function created() {
		this.showing = 0;  // 标记组件正在加载
		this.init(this.$route.query);  // 使用路由query参数初始化
		// 可选：在初始化前检查用户权限
		// this.check_auth(() => {
		// 	this.init(this.$route.query);
		// })
	},
	/**
	 * 组件挂载完成时触发
	 * DOM已经渲染到页面，showing设为100表示加载完成
	 */
	mounted: function mounted() {
		this.showing = 100;  // 标记组件加载完成
	},
	/**
	 * 组件销毁前触发
	 * 清理资源，触发end_before事件钩子
	 */
	beforeDestroy: function beforeDestroy() {
		this.events('end_before');  // 触发销毁前事件
	}
};
