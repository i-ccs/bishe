<template>
	<el-main class="bg table_wrap user premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="用户昵称">
							<el-input v-model="query.nickname" placeholder="请输入昵称搜索" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label=" ">
							<div class="premium-search-btns">
								<el-button type="primary" @click="search()" icon="el-icon-search">查询</el-button>
								<el-button @click="reset()" icon="el-icon-refresh">重置</el-button>
							</div>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
		</el-card>

		<el-card class="premium-table-card" shadow="never">
			<div class="premium-table-btns">
				<el-button v-if="user_group == '管理员'" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">新增管理员</el-button>
				<el-button v-if="user_group == '管理员'" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column fixed type="selection" width="55"></el-table-column>
				<el-table-column label="头像" width="100">
					<template slot-scope="scope">
						<el-avatar :src="$fullUrl(scope.row.avatar)" :size="50">
							<img src="../../../public/img/bg.jpg" />
						</el-avatar>
					</template>
				</el-table-column>
				<el-table-column prop="nickname" label="昵称" min-width="120"></el-table-column>
				<el-table-column prop="username" label="用户名" min-width="120"></el-table-column>
				<el-table-column prop="user_group" label="用户组" min-width="120">
					<template slot-scope="scope">
						<el-tag size="small">{{scope.row.user_group}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="email" label="邮箱" min-width="180"></el-table-column>
				<el-table-column prop="state" label="账号状态" width="100">
					<template slot-scope="scope">
						<el-tag :type="scope.row.state === 1 ? 'success' : 'danger'" size="small">
							{{list_state.getVal("text",{"value":scope.row.state})}}
						</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="create_time" label="注册时间" min-width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column fixed="right" label="操作" width="100">
					<template slot-scope="scope">
						<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
					</template>
				</el-table-column>
			</el-table>

			<div class="premium-pagination-wrap">
				<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page="query.page"
					:page-sizes="[7, 10, 30, 100]" :page-size="query.size" layout="total, sizes, prev, pager, next, jumper" :total="count">
				</el-pagination>
			</div>
		</el-card>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				url_get_list: "~/api/user/get_list?like=0",
				url_del: "~/api/user/del?",
				field:"user_id",
				query: {
					size: 10,
					page: 1,
					nickname: "",
					user_group: "管理员",
					orderby: `create_time desc`
				},
				list: [],
				list_state: [{ text: '可用', value: 1 }, { text: '异常', value: 2 }, { text: '已冻结', value: 3 }, { text: '已注销', value: 4 }],
				list_user_group: []
			}
		},
		methods: {
			async get_list_user_group(){
				var json = await this.$get("~/api/user_group/get_list?");
				if(json.result){ this.list_user_group = json.result.list; }
			},
			reset() {
				this.query = { size: 10, page: 1, nickname: "", user_group: "管理员", orderby: `create_time desc` };
				this.get_list();
			}
		},
		created(){ this.get_list_user_group(); }
	}
</script>

<style scoped>
</style>
