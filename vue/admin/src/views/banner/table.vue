<template>
	<el-main class="bg table_wrap premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="轮播图标题">
							<el-input v-model="query.title" placeholder="输入关键字搜索" prefix-icon="el-icon-search"></el-input>
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
				<el-button v-if="user_group == '管理员' || $check_action('/banner/view')" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">新增轮播图</el-button>
				<el-button v-if="user_group == '管理员' || $check_action('/banner/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" label="预览图" width="180">
					<template slot-scope="scope">
						<el-image style="width: 140px; height: 70px; border-radius: 8px;" :src="$fullUrl(scope.row.img)" :preview-src-list="[$fullUrl(scope.row.img)]">
							<div slot="error" class="image-slot"><i class="el-icon-picture-outline" style="font-size: 30px; color: #ccc;"></i></div>
						</el-image>
					</template>
				</el-table-column>
				<el-table-column align="center" label="标题" prop="title" min-width="150" show-overflow-tooltip></el-table-column>
				<el-table-column align="center" label="跳转链接" prop="url" min-width="200" show-overflow-tooltip></el-table-column>

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
				field: "banner_id",
				url_get_list: "~/api/banner/get_list?like=0",
				url_del: "~/api/banner/del?",
				query: { size: 10, page: 1, title: "", orderby: `banner_id desc` },
				list: [],
			}
		},
		methods: {
			reset() {
				this.query = { size: 10, page: 1, title: "", orderby: `banner_id desc` };
				this.get_list();
			}
		}
	}
</script>

<style scoped>
</style>
