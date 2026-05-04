<template>
	<el-main class="bg table_wrap comtabel_t premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form" label-width="120">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="商品名称">
							<el-input v-model="query.product_name" placeholder="请输入商品名称" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="商品类别">
							<el-input v-model="query.product_category" placeholder="请输入商品类别" prefix-icon="el-icon-folder"></el-input>
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
				<router-link v-if="$check_action('/commodity_information/view','add')" to="./view" class="el-button el-button--primary">
					<i class="el-icon-plus"></i> 新增商品
				</router-link>
				<el-button v-if="$check_action('/commodity_information/table','del') || $check_action('/commodity_information/view','del')" 
					type="danger" @click="delInfo()" icon="el-icon-delete" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" id="dataTable">
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" prop="product_code" label="商品编码" v-if="$check_field('get','product_code')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="product_name" label="商品名称" v-if="$check_field('get','product_name')" min-width="150"></el-table-column>
				<el-table-column align="center" prop="product_category" label="商品类别" v-if="$check_field('get','product_category')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="product_brand" label="商品品牌" v-if="$check_field('get','product_brand')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="product_inventory" label="商品库存" v-if="$check_field('get','product_inventory')" min-width="100">
					<template slot-scope="scope">
						<el-tag :type="scope.row.product_inventory < 10 ? 'danger' : 'success'">{{scope.row.product_inventory}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="product_images" label="商品图片" v-if="$check_field('get','product_images')" width="120">
					<template slot-scope="scope">
						<el-image style="width: 60px; height: 60px; border-radius: 8px;" :src="$fullUrl(scope.row['product_images'])" :preview-src-list="[$fullUrl(scope.row['product_images'])]">
							<div slot="error" class="image-slot"><i class="el-icon-picture-outline" style="font-size: 30px; color: #ccc;"></i></div>
						</el-image>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="commodity_price" label="商品价格" v-if="$check_field('get','commodity_price')" min-width="100">
					<template slot-scope="scope"><span style="color: #f56c6c; font-weight: 600;">¥ {{scope.row.commodity_price}}</span></template>
				</el-table-column>
				<el-table-column align="center" prop="create_time" label="创建时间" min-width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column align="center" fixed="right" label="操作" min-width="250" 
					v-if="$check_action('/commodity_information/table','set') || $check_action('/commodity_information/view','set') || $check_action('/commodity_information/view','get')">
					<template slot-scope="scope">
						<div class="view_a">
							<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
							<el-button class="el-button el-button--primary el-button--mini is-plain" @click="to_table(scope.row,'/sales_information/view')" v-if="($check_action('/sales_information/table','add') || $check_action('/sales_information/view','add')) && !scope.row['sales_information_limit']">销售</el-button>
							<el-button class="el-button el-button--primary el-button--mini is-plain" @click="to_table(scope.row,'/purchasing_information/view')" v-if="($check_action('/purchasing_information/table','add') || $check_action('/purchasing_information/view','add')) && !scope.row['purchasing_information_limit']">采购</el-button>
							<el-button class="el-button el-button--primary el-button--mini is-plain" @click="to_table(scope.row,'/inventory_information/view')" v-if="($check_action('/inventory_information/table','add') || $check_action('/inventory_information/view','add')) && !scope.row['inventory_information_limit']">库存</el-button>
						</div>
					</template>
				</el-table-column>
			</el-table>

			<div class="premium-pagination-wrap">
				<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
					:current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size"
					layout="total, sizes, prev, pager, next, jumper" :total="count">
				</el-pagination>
			</div>
		</el-card>

		<div class="modal_wrap" v-if="showModal">
			<div class="modal_box">
				<p class="modal_box_title">重要提醒</p>
				<p class="modal_box_text">当前有数据达到预警值！</p>
				<p class="modal_box_text">{{ message }}</p>
				<div class="btn_box">
					<span @click="closeModal">取消</span>
					<span @click="closeModal">确定</span>
				</div>
			</div>
		</div>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				showModal: false,
				url_get_list: "~/api/commodity_information/get_list?like=0",
				url_del: "~/api/commodity_information/del?",
				field: "commodity_information_id",
				query: {
					"size": 7,
					"page": 1,
					"product_name": "",
					"product_category": "",
					"orderby": `create_time desc`
				},
				list: [],
				message: '',
			}
		},
		methods: {
			closeModal(){ this.showModal = false; },
			get_list_after: function get_list_after(res, func, url) {
				let _this = this
				_this.list.map((item) => {
					let param = {
						source_table: "commodity_information",
						source_id: item.commodity_information_id,
						source_user_id: _this.user.user_id
					};
					// 销售限制逻辑
					if(item.sales_information_limit_times > 0){
						_this.$get("~/api/sales_information/count?", param, (result)=>{
							if(result && typeof result === 'object' && result.result !== undefined){
								_this.$set(item,'sales_information_limit', result.result >= item.sales_information_limit_times);
							}
						})
					}
					// 采购限制逻辑
					if(item.purchasing_information_limit_times > 0){
						_this.$get("~/api/purchasing_information/count?",param,(result)=>{
							if(result){ _this.$set(item,'purchasing_information_limit', result.result >= item.purchasing_information_limit_times); }
						})
					}
					// 库存限制逻辑
					if(item.inventory_information_limit_times > 0){
						_this.$get("~/api/inventory_information/count?",param,(result)=>{
							if(result){ _this.$set(item,'inventory_information_limit', result.result >= item.inventory_information_limit_times); }
						})
					}
					Object.assign(item, param)
				})
			},
		}
	}
</script>

<style scoped>
</style>
