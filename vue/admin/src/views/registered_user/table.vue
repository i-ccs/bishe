<template>
	<el-main class="bg table_wrap comtabel_t premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="用户姓名">
							<el-input v-model="query.user_name" placeholder="搜索真实姓名" prefix-icon="el-icon-user"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="用户性别">
							<el-select v-model="query.user_gender" style="width: 100%">
								<el-option value="">全部</el-option>
								<el-option v-for="o in list_user_gender" :key="o.value" :label="o.text" :value="o.value"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :lg="6">
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
				<el-button v-if="$check_action('/registered_user/view','add')" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">新增用户</el-button>
				<el-button v-if="$check_action('/registered_user/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column fixed type="selection" width="55" align="center"></el-table-column>
				<el-table-column prop="user_id" label="ID" width="80" align="center"></el-table-column>
				<el-table-column prop="nick_name" label="昵称" min-width="120" align="center"></el-table-column>
				<el-table-column prop="user_name" label="用户名" min-width="120" align="center"></el-table-column>
				<el-table-column prop="user_gender" label="性别" v-if="$check_field('get','user_gender')" width="80" align="center">
					<template slot-scope="scope">
						<el-tag :type="scope.row.user_gender === 0 ? '' : 'danger'" size="mini">
							{{ scope.row.user_gender === 0 ? '男' : '女' }}
						</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="create_time" label="创建时间" min-width="160" align="center">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>
				<el-table-column prop="update_time" label="更新时间" min-width="160" align="center">
					<template slot-scope="scope">{{ $toTime(scope.row["update_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column fixed="right" label="操作" width="100" align="center">
					<template slot-scope="scope">
						<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?user_id=' + scope.row['user_id']">详情</router-link>
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
				showModal: false,
				url_get_list: "~/api/registered_user/get_list?like=0",
				url_del: "~/api/registered_user/del?",
				field: "registered_user_id",
				query: { "size": 7, "page": 1, "user_name": "", "user_gender": "", "orderby": `create_time desc` },
				list: [],
				list_user_gender: [
					{ text: '男', value: 0 },
					{ text: '女', value: 1 }
				],
				message: '',
			}
		},
		methods: {
			closeModal(){ this.showModal = false; },
			delInfo() {
				var list = this.selection;
				if (list.length === 0) { return this.$message.info('选择对象不能为空!'); }
				this.$confirm('此操作将永久删除用户及其账号, 是否继续？', '提示', { type: 'warning' }).then(async () => {
					await this.delAll(list, async (items) => {
						for(let item of items){ await this.$get("~/api/user/del?", {user_id: item.user_id}); }
						this.$message.success('删除成功!');
						this.get_list();
					});
				});
			},
			get_list_after(res){
				for (let item of this.list){
					this.$get("~/api/user/get_obj?", { user_id: item.user_id }, (json) => {
						if (json.result && json.result.obj){
							this.$set(item, 'user_name', json.result.obj.user_name);
							this.$set(item, 'nick_name', json.result.obj.nick_name);
						}
					});
				}
			},
		}
	}
</script>

<style scoped>
</style>
