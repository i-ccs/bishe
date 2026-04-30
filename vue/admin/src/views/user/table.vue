<template>
	<el-main class="bg table_wrap user">
		<el-form label-position="right" :model="query" class="form p_4" label-width="120">
			<el-row class="rows row1" type="flex" justify="center">
				<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="用户名">
						<el-input v-model="query.user_name" placeholder="请输入用户名"></el-input>
					</el-form-item>
				</el-col>
				<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="性别">
						<el-select v-model="query.user_gender" placeholder="请选择性别" clearable="">
							<el-option label="全部" value=""></el-option>
							<el-option label="男" :value="1"></el-option>
							<el-option label="女" :value="0"></el-option>
						</el-select>
					</el-form-item>
				</el-col>
			</el-row>
			<el-row class="rows row2" type="flex" justify="center">
				<el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap" style="text-align: center;">
					<el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
					<el-button @click="reset()" class="search_btn_reset">重置</el-button>
					<el-button v-if="user_group == '管理员'" class="search_btn_del" type="danger" @click="delInfo()">删除</el-button>
					<el-button v-if="user_group == '管理员' " class="search_btn_add" @click="$router.push('./view?')">添加</el-button>
				</el-col>
			</el-row>
		</el-form>
		<el-table border :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%; table-layout: fixed;" stripe>

			<el-table-column fixed type="selection" tooltip-effect="dark" align="center">
			</el-table-column>

			<el-table-column fixed prop="nick_name" label="昵称" align="center">
			</el-table-column>

			<el-table-column label="头像" align="center">
				<template slot-scope="scope">
					<el-avatar :src="$fullUrl(scope.row.avatar)" style="width: 80px;height: 80px;">
						<img src="../../../public/img/bg.jpg">
					</el-avatar>
				</template>
			</el-table-column>

			<el-table-column prop="user_name" label="用户名" sortable align="center">
			</el-table-column>

			<el-table-column prop="user_gender" label="性别" sortable align="center">
				<template slot-scope="scope">
					{{ $toGender(scope.row.user_gender) }}
				</template>
			</el-table-column>

			<el-table-column prop="account_type" label="账号类型" sortable align="center">
				<template slot-scope="scope">
					{{scope.row.account_type || scope.row.user_group}}
				</template>
			</el-table-column>

<!--			<el-table-column prop="phone" label="手机号码" sortable align="center">-->
<!--			</el-table-column>-->

<!--			<el-table-column prop="phone_state" label="手机认证" sortable align="center">-->
<!--				<template slot-scope="scope">-->
<!--          <span v-if="scope.row.phone_state === 0">未认证</span>-->
<!--          <span v-if="scope.row.phone_state === 1">认证中</span>-->
<!--          <span v-if="scope.row.phone_state === 2">已认证</span>-->
<!--				</template>-->
<!--			</el-table-column>-->

			<el-table-column prop="email" label="邮箱" sortable align="center">
			</el-table-column>

<!--			<el-table-column prop="email_state" label="邮箱状态" sortable align="center">-->
<!--				<template slot-scope="scope">-->
<!--          <span v-if="scope.row.email_state === 0">未认证</span>-->
<!--          <span v-if="scope.row.email_state === 1">认证中</span>-->
<!--          <span v-if="scope.row.email_state === 2">已认证</span>-->
<!--				</template>-->
<!--			</el-table-column>-->

			<el-table-column prop="state" label="状态" sortable align="center">
				<template slot-scope="scope">
					{{list_state.getVal("text",{"value":scope.row.state})}}
				</template>
			</el-table-column>

			<!--<el-table-column prop="login_time" label="上次登录时间" sortable align="center">
                <template slot-scope="scope">
                    {{ $toTime(scope.row["login_time"],"yyyy-MM-dd hh:mm:ss") }}
                </template>
			</el-table-column>-->

			<el-table-column sortable prop="create_time" label="创建时间" align="center">
			    <template slot-scope="scope">
			        {{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm:ss") }}
			    </template>
			</el-table-column>

			<!-- 操作 -->
			<el-table-column fixed="right" label="操作" align="center">
				<template slot-scope="scope">
					<router-link class="el-button el-button--small is-plain el-button--primary" :to="'./view?' + field + '=' + scope.row[field]" size="small">
            		修改
					</router-link>
				</template>
			</el-table-column>
			<!-- /操作 -->

		</el-table>

		<!-- 分页器 -->
		<div class="mt text_center">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size" layout="total, sizes, prev, pager, next, jumper" :total="count">
			</el-pagination>
		</div>
		<!-- /分页器 -->

	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";

	export default {
		mixins: [mixin],
		data() {
			return {
				// 获取数据地址
				url_get_list: "~/api/user/get_list?like=0",
				url_del: "~/api/user/del?",

				// 字段ID
				field:"user_id",

				// 查询
				query: {
					size: 10,
					page: 1,
					user_name: "",
					user_gender: "",
					user_group: "",
					login_time: "",
					create_time: ""
				},

				// 数据
				list: [],

				// 账号状态
				list_state: [{
					text: '可用',
					value: 1
				}, {
					text: '异常',
					value: 2
				}, {
					text: '已冻结',
					value: 3
				}, {
					text: '已注销',
					value: 4
				}],

				// 认证状态
				list_is_state: [{
					text: "未认证",
					value: 0
				}, {
					text: "认证中",
					value: 1
				}, {
					text: "已认证",
					value: 2
				}],

				// 用户组
				list_user_group: []
			}
		},
		methods: {
			deleteRow(index, rows) {
				rows.splice(index, 1);
			},

			async get_list_user_group(){
				var json = await this.$get("~/api/user_group/get_list?");
				if(json.result){
					this.list_user_group = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},

			table_class({row, column, rowIndex, columnIndex}){
				return "table_class";
			},
      /**
       * 重置
       */
      reset() {
        this.query = {
          size: 10,
          page: 1,
          user_name: "",
          user_gender: "",
          user_group: "",
          login_time: "",
          create_time: ""
        }
        this.get_list()
      }
		},
		created(){
			this.get_list_user_group();
		}
	}
</script>

<style type="text/css">

</style>
