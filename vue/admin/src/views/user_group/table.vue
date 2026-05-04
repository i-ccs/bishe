<template>
	<el-main class="bg table_wrap premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="用户组名称">
							<el-input v-model="query.name" placeholder="输入名称搜索" prefix-icon="el-icon-search"></el-input>
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
				<el-button v-if="user_group == '管理员' || $check_action('/user_group/view')" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">新增用户组</el-button>
				<el-button v-if="user_group == '管理员' || $check_action('/user_group/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" fixed prop="name" label="用户组名称" min-width="150"></el-table-column>
				<el-table-column align="center" prop="display" label="优先级" width="100">
					<template slot-scope="scope">
						<el-tag size="small" type="info">{{scope.row.display}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="description" label="职能描述" min-width="300" show-overflow-tooltip></el-table-column>
				<el-table-column align="center" prop="create_time" label="创建时间" width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column align="center" fixed="right" label="操作" width="100">
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
				url_get_list: "~/api/user_group/get_list?like=0",
				url_del: "~/api/user_group/del?",
				field: "group_id",
				query: { size: 10, page: 1, name: "", orderby: `group_id asc` },
				list: [],
			}
		}
	}
</script>

<style scoped>
</style>
