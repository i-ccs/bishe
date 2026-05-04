<template>
	<el-main class="bg table_wrap premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="导航名称">
							<el-input v-model="query.name" placeholder="输入名称搜索" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="显示位置">
							<el-select v-model="query.location" style="width: 100%">
								<el-option value="">全部位置</el-option>
								<el-option v-for="obj in list_location" :key="obj.value" :label="obj.text" :value="obj.value"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="跳转方式">
							<el-select v-model="query.target" style="width: 100%">
								<el-option value="">全部方式</el-option>
								<el-option v-for="obj in list_target" :key="obj.value" :label="obj.text" :value="obj.value"></el-option>
							</el-select>
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
				<el-button v-if="user_group == '管理员' || $check_action('/nav/view')" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">新增导航</el-button>
				<el-button v-if="user_group == '管理员' || $check_action('/nav/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column fixed type="selection" width="55"></el-table-column>
				<el-table-column fixed prop="name" label="导航名称" min-width="120"></el-table-column>
				<el-table-column prop="father_id" label="父级菜单" width="120">
					<template slot-scope="scope">
						<el-tag size="small" type="info">{{getObj(list,scope.row.father_id,"nav_id").name || "一级菜单"}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="location" label="显示位置" width="100">
					<template slot-scope="scope">{{getObj(list_location,scope.row.location).text}}</template>
				</el-table-column>
				<el-table-column prop="target" label="跳转方式" width="120">
					<template slot-scope="scope">{{getObj(list_target,scope.row.target).text || "本页面"}}</template>
				</el-table-column>
				<el-table-column prop="url" label="链接地址" min-width="200" show-overflow-tooltip></el-table-column>
				<el-table-column prop="create_time" label="创建时间" width="160">
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
	import mixin from "../../mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				url_get_list: "~/api/nav/get_list?like=0",
				url_del: "~/api/nav/del?",
				field: "nav_id",
				query: { size: 10, page: 1, name: "", location:"", target:"", orderby: `nav_id asc` },
				list: [],
				list_location: [
					{ text: "顶部导航", value: "top" },
					{ text: "侧边导航", value: "side" },
					{ text: "底部导航", value: "foot" }
				],
				list_target: [
					{ text: '新页面 (_blank)', value: "_blank" },
					{ text: '本页面 (_self)', value: "_self" },
					{ text: '父窗口 (_parent)', value: "_parent" },
					{ text: '全窗口 (_top)', value: "_top" }
				],
			}
		}
	}
</script>

<style scoped>
</style>
