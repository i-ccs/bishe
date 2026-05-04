<template>
	<el-main class="bg table_wrap premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="评论人昵称">
							<el-input v-model="query.nickname" placeholder="输入昵称搜索" prefix-icon="el-icon-user"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="评论内容">
							<el-input v-model="query.content" placeholder="输入内容关键字" prefix-icon="el-icon-chat-dot-round"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :lg="6">
						<el-form-item label=" ">
							<div class="premium-search-btns">
								<el-button type="primary" @click="search()" icon="el-icon-search">查询</el-button>
								<el-button @click="resetSearch()" icon="el-icon-refresh">重置</el-button>
							</div>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
		</el-card>

		<el-card class="premium-table-card" shadow="never">
			<div class="premium-table-btns">
				<el-button v-if="$check_action('/comment/table','del')" type="danger" icon="el-icon-delete" @click="delInfo()" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column fixed type="selection" width="55"></el-table-column>
				<el-table-column label="用户" width="180">
					<template slot-scope="scope">
						<div style="display: flex; align-items: center; gap: 10px;">
							<el-avatar size="small" :src="$fullUrl(scope.row.avatar)">
								<img src="/img/error.png" />
							</el-avatar>
							<span>{{scope.row.nickname}}</span>
						</div>
					</template>
				</el-table-column>
				<el-table-column prop="content" label="评论内容" min-width="250" show-overflow-tooltip>
					<template slot-scope="scope">
						<div v-html="scope.row.content"></div>
					</template>
				</el-table-column>
				<el-table-column prop="create_time" label="评论时间" min-width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column fixed="right" label="操作" width="200">
					<template slot-scope="scope">
						<div class="view_a">
							<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
							<el-button v-if="!scope.row['reply_to_id']" class="el-button el-button--primary el-button--mini is-plain" @click="viewReplies(scope.row)">查看回复</el-button>
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
				url_get_list: "~/api/comment/get_list?like=0",
				url_del: "~/api/comment/del?",
				field:"comment_id",
				query: { size: 10, page: 1, content: "", nickname: "", source_table: "", source_field: "", source_id: 0, orderby: `create_time desc` },
				list: [],
				list_user: []
			}
		},
		methods: {
			async get_list_user(){
				var json = await this.$get("~/api/user/get_list?");
				if(json.result){ this.list_user = json.result.list; }
			},
			resetSearch(){
				this.query.page = 1; this.query.nickname = ""; this.query.content = "";
				this.get_list();
			},
			viewReplies(row){
				this.query.reply_to_id = row[this.field];
				this.search();
			}
		},
		created(){ this.get_list_user(); }
	}
</script>

<style scoped>
</style>
