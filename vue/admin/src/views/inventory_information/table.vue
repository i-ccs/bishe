<template>
	<el-main class="bg table_wrap comtabel_t premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form" label-width="120">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="商品名称">
							<el-input v-model="query.prod_name" placeholder="请输入商品名称" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="商品类别">
							<el-input v-model="query.prod_category" placeholder="请输入商品类别" prefix-icon="el-icon-folder"></el-input>
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
				<router-link v-if="$check_action('/inventory_information/view','add')" to="./view" class="el-button el-button--primary">
					<i class="el-icon-plus"></i> 新增核对记录
				</router-link>
				<el-button v-if="$check_action('/inventory_information/table','del') || $check_action('/inventory_information/view','del')" 
					type="danger" @click="delInfo()" icon="el-icon-delete" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" id="dataTable">
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" prop="prod_code" label="商品编码" v-if="$check_field('get','prod_code')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="prod_name" label="商品名称" v-if="$check_field('get','prod_name')" min-width="150"></el-table-column>
				<el-table-column align="center" prop="prod_category" label="商品类别" v-if="$check_field('get','prod_category')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="prod_brand" label="商品品牌" v-if="$check_field('get','prod_brand')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="prod_invent" label="系统账面库存" v-if="$check_field('get','prod_invent')" min-width="120"></el-table-column>
				<el-table-column align="center" prop="check_quant" label="实际盘点数量" v-if="$check_field('get','check_quant')" min-width="120">
					<template slot-scope="scope">
						<el-tag :type="scope.row.check_quant == scope.row.prod_invent ? 'success' : 'warning'">{{scope.row.check_quant}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="check_date" label="核对日期" v-if="$check_field('get','check_date')" min-width="120">
					<template slot-scope="scope">{{ $toTime(scope.row["check_date"],"yyyy-MM-dd") }}</template>
				</el-table-column>
				<el-table-column align="center" prop="inventory" label="变动说明" v-if="$check_field('get','inventory')" min-width="150" show-overflow-tooltip></el-table-column>

				<el-table-column align="center" fixed="right" label="操作" min-width="100">
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
				url_get_list: "~/api/inventory_information/get_list?like=0",
				url_del: "~/api/inventory_information/del?",
				field: "invent_info_id",
				query: {
					"size": 7,
					"page": 1,
					"prod_name": "",
					"prod_category": "",
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
