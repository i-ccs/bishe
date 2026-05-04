<template>
	<el-main class="bg table_wrap article premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="文章标题">
							<el-input v-model="query.title" placeholder="输入关键字搜索" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="文章分类">
							<el-select v-model="query.type" style="width: 100%">
								<el-option value="">全部类别</el-option>
								<el-option v-for="(o,i) in list_category" :value="o.name" :key="i" :label="o.name"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="标签">
							<el-input v-model="query.tag" placeholder="搜索相关标签" prefix-icon="el-icon-collection-tag"></el-input>
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
				<el-button v-if="$check_action('/article/view')" type="primary" icon="el-icon-plus" @click="$router.push('./view?')">发布文章</el-button>
				<el-button v-if="$check_action('/article/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" label="封面" width="100">
					<template slot-scope="scope">
						<el-image style="width: 60px; height: 60px; border-radius: 6px;" :src="$fullUrl(scope.row.img)" :preview-src-list="[$fullUrl(scope.row.img)]">
							<div slot="error" class="image-slot"><i class="el-icon-picture-outline" style="font-size: 30px; color: #ccc;"></i></div>
						</el-image>
					</template>
				</el-table-column>
				<el-table-column align="center" fixed prop="title" label="文章标题" min-width="200" show-overflow-tooltip></el-table-column>
				<el-table-column align="center" prop="type" label="分类" width="120">
					<template slot-scope="scope">
						<el-tag size="small" type="info">{{scope.row.type}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="tag" label="标签" min-width="150"></el-table-column>
				<el-table-column align="center" prop="create_time" label="发布时间" min-width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column align="center" fixed="right" label="操作" width="180">
					<template slot-scope="scope">
						<div class="view_a">
							<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
							<router-link class="el-button el-button--primary el-button--mini is-plain" :to="'../comment/table?size=10&page=1&source_table=article&source_field=' + field + '&source_id=' + scope.row[field]">评论</router-link>
						</div>
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
				url_get_list: "~/api/article/get_list?like=0",
				url_del: "~/api/article/del?",
				field:"article_id",
				query: { size: 10, page: 1, title: "", tag: "", type: "", orderby: `create_time desc` },
				list: [],
				list_category: []
			}
		},
		methods: {
			async get_category() {
				var json = await this.$get("~/api/category/get_list?");
				if(json.result){ this.list_category = json.result.list; }
			},
			reset() {
				this.query = { size: 10, page: 1, title: "", tag: "", type: "", orderby: `create_time desc` };
				this.get_list();
			}
		},
		created(){ this.get_category(); }
	}
</script>

<style scoped>
</style>
