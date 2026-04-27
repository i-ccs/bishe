<template>
  <div class="page_search search_index">
	<div class="warp">
	  <div class="container">
		<div class="row">
		  <div class="col-12">
			<div class="card_result_search">
			  <div class="title">搜索结果</div>

				<!-- 文章搜索结果 -->
			  <list_result_search
				:list="result_article"
				title="行业资讯"
				source_table="article"
			  ></list_result_search>


						  <list_result_search
				v-if="$check_action('/registered_user/list', 'get')"
				:list="result_registered_user_user_name"
				title="注册用户用户姓名"
				source_table="registered_user"
			  ></list_result_search>
								  <list_result_search
				v-if="$check_action('/registered_user/list', 'get')"
				:list="result_registered_user_user_gender"
				title="注册用户用户性别"
				source_table="registered_user"
			  ></list_result_search>
												  <list_result_search
				v-if="$check_action('/commodity_information/list', 'get')"
				:list="result_commodity_information_product_name"
				title="商品信息商品名称"
				source_table="commodity_information"
			  ></list_result_search>
								  <list_result_search
				v-if="$check_action('/commodity_information/list', 'get')"
				:list="result_commodity_information_product_category"
				title="商品信息商品类别"
				source_table="commodity_information"
			  ></list_result_search>
																																	  <list_result_search
				v-if="$check_action('/sales_information/list', 'get')"
				:list="result_sales_information_product_name"
				title="销售信息商品名称"
				source_table="sales_information"
			  ></list_result_search>
								  <list_result_search
				v-if="$check_action('/sales_information/list', 'get')"
				:list="result_sales_information_product_category"
				title="销售信息商品类别"
				source_table="sales_information"
			  ></list_result_search>
																																	  <list_result_search
				v-if="$check_action('/supply_information/list', 'get')"
				:list="result_supply_information_supplier_name"
				title="供应信息供应商名称"
				source_table="supply_information"
			  ></list_result_search>
											  <list_result_search
				v-if="$check_action('/supply_information/list', 'get')"
				:list="result_supply_information_commodity_category"
				title="供应信息商品类别"
				source_table="supply_information"
			  ></list_result_search>
																											  <list_result_search
				v-if="$check_action('/purchasing_information/list', 'get')"
				:list="result_purchasing_information_product_name"
				title="采购信息商品名称"
				source_table="purchasing_information"
			  ></list_result_search>
								  <list_result_search
				v-if="$check_action('/purchasing_information/list', 'get')"
				:list="result_purchasing_information_product_category"
				title="采购信息商品类别"
				source_table="purchasing_information"
			  ></list_result_search>
																																										  <list_result_search
				v-if="$check_action('/inventory_information/list', 'get')"
				:list="result_inventory_information_product_name"
				title="库存信息商品名称"
				source_table="inventory_information"
			  ></list_result_search>
								  <list_result_search
				v-if="$check_action('/inventory_information/list', 'get')"
				:list="result_inventory_information_product_category"
				title="库存信息商品类别"
				source_table="inventory_information"
			  ></list_result_search>
																					</div>
		  </div>
		</div>
	  </div>
	</div>
  </div>
</template>

<script>
import mixin from "../../mixins/page.js";
import list_result_search from "../../components/diy/list_result_search.vue";

export default {
  mixins: [mixin],
  data() {
	return {
	  "query": {
		word: "",
	  },
	  "result_article": [],
						"result_registered_user_user_name":[],
								"result_registered_user_user_gender":[],
												"result_commodity_information_product_name":[],
								"result_commodity_information_product_category":[],
																																	"result_sales_information_product_name":[],
								"result_sales_information_product_category":[],
																																	"result_supply_information_supplier_name":[],
											"result_supply_information_commodity_category":[],
																											"result_purchasing_information_product_name":[],
								"result_purchasing_information_product_category":[],
																																										"result_inventory_information_product_name":[],
								"result_inventory_information_product_category":[],
																			};
  },
  methods: {
	/**
	 * 获取文章
	 */
	get_article() {
	  this.$get("~/api/article/get_list?like=0", { page: 1, size: 10, title: this.query.word }, (json) => {
		if (json.result) {
		  this.result_article = json.result.list;
		}
	  });
	},

				/**
	 * 获取user_name
	 */
	get_registered_user_user_name(){
		let url = "~/api/registered_user/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "user_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_registered_user_user_name = json.result.list;
			result_registered_user_user_name.map(o => o.title = o['user_name'])
	  			this.result_registered_user_user_name = result_registered_user_user_name
		 	}
		});
	},
						/**
	 * 获取user_gender
	 */
	get_registered_user_user_gender(){
		let url = "~/api/registered_user/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "user_gender": this.query.word }, (json) => {
		  if (json.result) {
			var result_registered_user_user_gender = json.result.list;
			result_registered_user_user_gender.map(o => o.title = o['user_gender'])
	  			this.result_registered_user_user_gender = result_registered_user_user_gender
		 	}
		});
	},
										/**
	 * 获取product_name
	 */
	get_commodity_information_product_name(){
		let url = "~/api/commodity_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_commodity_information_product_name = json.result.list;
			result_commodity_information_product_name.map(o => o.title = o['product_name'])
	  			this.result_commodity_information_product_name = result_commodity_information_product_name
		 	}
		});
	},
						/**
	 * 获取product_category
	 */
	get_commodity_information_product_category(){
		let url = "~/api/commodity_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_category": this.query.word }, (json) => {
		  if (json.result) {
			var result_commodity_information_product_category = json.result.list;
			result_commodity_information_product_category.map(o => o.title = o['product_category'])
	  			this.result_commodity_information_product_category = result_commodity_information_product_category
		 	}
		});
	},
																															/**
	 * 获取product_name
	 */
	get_sales_information_product_name(){
		let url = "~/api/sales_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_sales_information_product_name = json.result.list;
			result_sales_information_product_name.map(o => o.title = o['product_name'])
	  			this.result_sales_information_product_name = result_sales_information_product_name
		 	}
		});
	},
						/**
	 * 获取product_category
	 */
	get_sales_information_product_category(){
		let url = "~/api/sales_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_category": this.query.word }, (json) => {
		  if (json.result) {
			var result_sales_information_product_category = json.result.list;
			result_sales_information_product_category.map(o => o.title = o['product_category'])
	  			this.result_sales_information_product_category = result_sales_information_product_category
		 	}
		});
	},
																															/**
	 * 获取supplier_name
	 */
	get_supply_information_supplier_name(){
		let url = "~/api/supply_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "supplier_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_supply_information_supplier_name = json.result.list;
			result_supply_information_supplier_name.map(o => o.title = o['supplier_name'])
	  			this.result_supply_information_supplier_name = result_supply_information_supplier_name
		 	}
		});
	},
									/**
	 * 获取commodity_category
	 */
	get_supply_information_commodity_category(){
		let url = "~/api/supply_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "commodity_category": this.query.word }, (json) => {
		  if (json.result) {
			var result_supply_information_commodity_category = json.result.list;
			result_supply_information_commodity_category.map(o => o.title = o['commodity_category'])
	  			this.result_supply_information_commodity_category = result_supply_information_commodity_category
		 	}
		});
	},
																									/**
	 * 获取product_name
	 */
	get_purchasing_information_product_name(){
		let url = "~/api/purchasing_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_purchasing_information_product_name = json.result.list;
			result_purchasing_information_product_name.map(o => o.title = o['product_name'])
	  			this.result_purchasing_information_product_name = result_purchasing_information_product_name
		 	}
		});
	},
						/**
	 * 获取product_category
	 */
	get_purchasing_information_product_category(){
		let url = "~/api/purchasing_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_category": this.query.word }, (json) => {
		  if (json.result) {
			var result_purchasing_information_product_category = json.result.list;
			result_purchasing_information_product_category.map(o => o.title = o['product_category'])
	  			this.result_purchasing_information_product_category = result_purchasing_information_product_category
		 	}
		});
	},
																																								/**
	 * 获取product_name
	 */
	get_inventory_information_product_name(){
		let url = "~/api/inventory_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_name": this.query.word }, (json) => {
		  if (json.result) {
			var result_inventory_information_product_name = json.result.list;
			result_inventory_information_product_name.map(o => o.title = o['product_name'])
	  			this.result_inventory_information_product_name = result_inventory_information_product_name
		 	}
		});
	},
						/**
	 * 获取product_category
	 */
	get_inventory_information_product_category(){
		let url = "~/api/inventory_information/get_list?like=0";
				this.$get(url, { page: 1, size: 10, "product_category": this.query.word }, (json) => {
		  if (json.result) {
			var result_inventory_information_product_category = json.result.list;
			result_inventory_information_product_category.map(o => o.title = o['product_category'])
	  			this.result_inventory_information_product_category = result_inventory_information_product_category
		 	}
		});
	},
																		
  },
  components: { list_result_search },
	created(){
    this.query.word = this.$route.query.word || "";
  },
  mounted() {
	this.get_article();
					this.get_registered_user_user_name();
							this.get_registered_user_user_gender();
											this.get_commodity_information_product_name();
							this.get_commodity_information_product_category();
																																this.get_sales_information_product_name();
							this.get_sales_information_product_category();
																																this.get_supply_information_supplier_name();
										this.get_supply_information_commodity_category();
																										this.get_purchasing_information_product_name();
							this.get_purchasing_information_product_category();
																																									this.get_inventory_information_product_name();
							this.get_inventory_information_product_category();
																		  },
  watch: {
	$route() {
	  $.push(this.query, this.$route.query);
	  this.get_article();
				  this.get_registered_user_user_name();
						  this.get_registered_user_user_gender();
										  this.get_commodity_information_product_name();
						  this.get_commodity_information_product_category();
																															  this.get_sales_information_product_name();
						  this.get_sales_information_product_category();
																															  this.get_supply_information_supplier_name();
									  this.get_supply_information_commodity_category();
																									  this.get_purchasing_information_product_name();
						  this.get_purchasing_information_product_category();
																																								  this.get_inventory_information_product_name();
						  this.get_inventory_information_product_category();
																			},
  },
};
</script>

<style scoped>
.card_search {
  text-align: center;
}
.card_result_search>.title {
  text-align: center;
  padding: 10px 0;
}
</style>
