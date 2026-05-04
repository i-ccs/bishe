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
				<router-link v-if="$check_action('/purchasing_information/view','add')" to="./view" class="el-button el-button--primary">
					<i class="el-icon-plus"></i> 新增采购
				</router-link>
				<el-button v-if="$check_action('/purchasing_information/table','del') || $check_action('/purchasing_information/view','del')" 
					type="danger" @click="delInfo()" icon="el-icon-delete" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" id="dataTable">
				<el-table-column fixed type="selection" width="55"></el-table-column>
				<el-table-column prop="purchase_order_number" label="采购单号" v-if="$check_field('get','purchase_order_number')" min-width="150"></el-table-column>
				<el-table-column prop="product_name" label="商品名称" v-if="$check_field('get','product_name')" min-width="150"></el-table-column>
				<el-table-column prop="supplier_name" label="供应商" v-if="$check_field('get','supplier_name')" min-width="150"></el-table-column>
				<el-table-column prop="purchase_date" label="采购日期" v-if="$check_field('get','purchase_date')" min-width="120">
					<template slot-scope="scope">{{ $toTime(scope.row["purchase_date"],"yyyy-MM-dd") }}</template>
				</el-table-column>
				<el-table-column prop="purchase_quantity" label="数量" v-if="$check_field('get','purchase_quantity')" min-width="100"></el-table-column>
				<el-table-column prop="purchase_unit_price" label="单价" v-if="$check_field('get','purchase_unit_price')" min-width="100">
					<template slot-scope="scope">¥ {{scope.row.purchase_unit_price}}</template>
				</el-table-column>
				<el-table-column prop="total_purchase_price" label="总金额" v-if="$check_field('get','total_purchase_price')" min-width="120">
					<template slot-scope="scope"><span style="color: #f56c6c; font-weight: 600;">¥ {{scope.row.total_purchase_price}}</span></template>
				</el-table-column>
				<el-table-column prop="procurement_status" label="采购备注" v-if="$check_field('get','procurement_status')" min-width="150" show-overflow-tooltip></el-table-column>

				<el-table-column fixed="right" label="操作" min-width="100">
					<template slot-scope="scope">
						<router-link class="el-button el-button--success el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
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
				url_get_list: "~/api/purchasing_information/get_list?like=0",
				url_del: "~/api/purchasing_information/del?",
				field: "purchasing_information_id",
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
		}
	}
</script>

<style scoped>
</style>
