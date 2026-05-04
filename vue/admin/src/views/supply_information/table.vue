<template>
	<el-main class="bg table_wrap comtabel_t premium-table-wrap">
		<el-card class="premium-search-card" shadow="never">
			<el-form label-position="top" :model="query" class="premium-search-form" label-width="120">
				<el-row :gutter="20">
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="供应商名称">
							<el-input v-model="query.supplier_name" placeholder="请输入供应商名称" prefix-icon="el-icon-search"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="商品类别">
							<el-select v-model="query.commodity_category" style="width: 100%">
								<el-option value="">全部类别</el-option>
								<el-option v-for="o in list_commodity_category" :key="o.product_category" :label="o.product_category" :value="o.product_category"></el-option>
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
				<router-link v-if="$check_action('/supply_information/view','add')" to="./view" class="el-button el-button--primary">
					<i class="el-icon-plus"></i> 新增供应商
				</router-link>
				<el-button v-if="$check_action('/supply_information/table','del') || $check_action('/supply_information/view','del')" 
					type="danger" @click="delInfo()" icon="el-icon-delete" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" id="dataTable">
				<el-table-column fixed type="selection" width="55"></el-table-column>
				<el-table-column prop="supplier_name" label="供应商名称" v-if="$check_field('get','supplier_name')" min-width="150"></el-table-column>
				<el-table-column prop="suppliers_phone_number" label="联系电话" v-if="$check_field('get','suppliers_phone_number')" min-width="120"></el-table-column>
				<el-table-column prop="commodity_category" label="主营类别" v-if="$check_field('get','commodity_category')" min-width="120"></el-table-column>
				<el-table-column prop="comprehensive_evaluation" label="综合评价" v-if="$check_field('get','comprehensive_evaluation')" min-width="120">
					<template slot-scope="scope">
						<el-rate v-if="!isNaN(parseFloat(scope.row.comprehensive_evaluation))" :value="parseFloat(scope.row.comprehensive_evaluation)" disabled text-color="#ff9900"></el-rate>
						<span v-else>{{scope.row.comprehensive_evaluation}}</span>
					</template>
				</el-table-column>
				<el-table-column prop="supply_frequency" label="供应频率" v-if="$check_field('get','supply_frequency')" min-width="100"></el-table-column>
				<el-table-column prop="cooperation_situation" label="合作状态" v-if="$check_field('get','cooperation_situation')" min-width="120">
					<template slot-scope="scope">
						<el-tag :type="scope.row.cooperation_situation === '长期合作' ? 'success' : 'info'">{{scope.row.cooperation_situation}}</el-tag>
					</template>
				</el-table-column>

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
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				showModal: false,
				url_get_list: "~/api/supply_information/get_list?like=0",
				url_del: "~/api/supply_information/del?",
				field: "supply_information_id",
				query: { "size": 7, "page": 1, "supplier_name": "", "commodity_category": "", "orderby": `create_time desc` },
				list: [],
				list_commodity_category: [],
				message: '',
			}
		},
		methods: {
			closeModal(){ this.showModal = false; },
			async get_list_commodity_category() {
				var json = await this.$get("~/api/commodity_information/get_list?");
				if(json.result){ this.list_commodity_category = json.result.list; }
			},
		},
		created() { this.get_list_commodity_category(); }
	}
</script>

<style scoped>
</style>
