<template>
	<el-main class="bg table_wrap comtabel_t">
		<el-form label-position="right" :model="query" class="form p_4" label-width="120">
			<el-row class="rows row1">



										<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="商品名称">
									<el-input v-model="query.product_name"></el-input>
								</el-form-item>
				</el-col>
									<el-col :xs="24" :sm="24" :lg="8" class="el_form_search_wrap">
					<el-form-item label="商品类别">
									<el-input v-model="query.product_category"></el-input>
								</el-form-item>
				</el-col>
																									</el-row>
	<el-row class="rows row2">

		<el-col :xs="24" :sm="24" :lg="24" class="search_btn_wrap search_btns">

				<el-col :xs="24" :sm="10" :lg="8" class="search_btn_1 search_btn_wrap_1 btns">

										<el-button type="primary" @click="search()" class="search_btn_find">查询</el-button>
						<el-button @click="reset()" style="margin-right: 74px;" class="search_btn_reset">重置</el-button>
																		

						<el-button v-if="$check_action('/commodity_information/table','del') || $check_action('/commodity_information/view','del')" class="search_btn_del" type="danger" @click="delInfo()">删除</el-button>
								
				</el-col>
		</el-col>
	</el-row >

		</el-form>
				<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" id="dataTable">
					<el-table-column fixed type="selection" tooltip-effect="dark" width="55">
			</el-table-column>
				<el-table-column prop="product_code" @sort-change="$sortChange" label="商品编码" 				v-if="$check_field('get','product_code')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_name" @sort-change="$sortChange" label="商品名称" 				v-if="$check_field('get','product_name')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_category" @sort-change="$sortChange" label="商品类别" 				v-if="$check_field('get','product_category')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_brand" @sort-change="$sortChange" label="商品品牌" 				v-if="$check_field('get','product_brand')" min-width="200">
					</el-table-column>
					<el-table-column prop="commodity_specifications" @sort-change="$sortChange" label="商品规格" 				v-if="$check_field('get','commodity_specifications')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_inventory" @sort-change="$sortChange" label="商品库存" 				v-if="$check_field('get','product_inventory')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_images" @sort-change="$sortChange" label="商品图片" 				v-if="$check_field('get','product_images')" min-width="200">
						<template slot-scope="scope">
					<el-image style="width: 100px; height: 100px" :src="$fullUrl(scope.row['product_images'])"
						:preview-src-list="[$fullUrl(scope.row['product_images'])]">
						<div slot="error" class="image-slot">
							<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
						</div>
					</el-image>
				</template>
					</el-table-column>
					<el-table-column prop="commodity_price" @sort-change="$sortChange" label="商品价格" 				v-if="$check_field('get','commodity_price')" min-width="200">
					</el-table-column>
					<el-table-column prop="product_introduction" @sort-change="$sortChange" label="商品介绍" 				v-if="$check_field('get','product_introduction')" min-width="200">
					</el-table-column>
			


            <el-table-column sortable prop="create_time" label="创建时间" min-width="200">
                <template slot-scope="scope">
                	{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm:ss") }}
                </template>
            </el-table-column>

			<el-table-column sortable prop="update_time" label="更新时间" min-width="200">
                <template slot-scope="scope">
                	{{ $toTime(scope.row["update_time"],"yyyy-MM-dd hh:mm:ss") }}
                </template>
			</el-table-column>







			<el-table-column fixed="right" label="操作" min-width="200" v-if="$check_action('/commodity_information/table','set') || $check_action('/commodity_information/view','set') || $check_action('/commodity_information/view','get') 
						|| $check_action('/sales_information/table','add') || $check_action('/sales_information/view','add') 
						|| $check_action('/purchasing_information/table','add') || $check_action('/purchasing_information/view','add') 
						|| $check_action('/inventory_information/table','add') || $check_action('/inventory_information/view','add') 
						" >


				<template slot-scope="scope">
					<div class="view_a">
					<router-link class="e-button el-button--small is-plain el-button--success" style="margin: 5px !important;"
					v-if="$check_action('/commodity_information/table','set') || $check_action('/commodity_information/view','set') || $check_action('/commodity_information/view','get')"
						:to="'./view?' + field + '=' + scope.row[field]"
						 size="small">
						<span>详情</span>
					</router-link>
						<!--跨表按钮-->
										<el-button class="e-button el-button--small is-plain el-button--primary" style="margin: 5px !important;" size="small" @click="to_table(scope.row,'/sales_information/view')" v-if="($check_action('/sales_information/table','add') || $check_action('/sales_information/view','add')) && !scope.row['sales_information_limit']">
						<span>销售</span>
					</el-button>
													<el-button class="e-button el-button--small is-plain el-button--primary" style="margin: 5px !important;" size="small" @click="to_table(scope.row,'/purchasing_information/view')" v-if="($check_action('/purchasing_information/table','add') || $check_action('/purchasing_information/view','add')) && !scope.row['purchasing_information_limit']">
						<span>采购</span>
					</el-button>
													<el-button class="e-button el-button--small is-plain el-button--primary" style="margin: 5px !important;" size="small" @click="to_table(scope.row,'/inventory_information/view')" v-if="($check_action('/inventory_information/table','add') || $check_action('/inventory_information/view','add')) && !scope.row['inventory_information_limit']">
						<span>库存</span>
					</el-button>
												<router-link v-if="$check_comment('/commodity_information/table')" class="e-button el-button--small is-plain el-button--primary"
								  :to="'../comment/table?size=10&page=1&source_table=commodity_information&source_field=' + field + '&source_id=' + scope.row[field]" size="small">
						<span>查看评论</span>
					</router-link>
					</div>
				</template>
			</el-table-column>

		</el-table>

		<!-- 分页器 -->
		<div class="mt text_center">
			<el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
				:current-page="query.page" :page-sizes="[7, 10, 30, 100]" :page-size="query.size"
				layout="total, sizes, prev, pager, next, jumper" :total="count">
			</el-pagination>
		</div>
		<!-- /分页器 -->
										
		<div class="modal_wrap" v-if="showModal">
			<div class="modal_box">
				<!-- <div class="modal_box_close" @click="closeModal">X</div> -->
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
				// 弹框
				showModal: false,
				// 获取数据地址
				url_get_list: "~/api/commodity_information/get_list?like=0",
				url_del: "~/api/commodity_information/del?",

				// 字段ID
				field: "commodity_information_id",

				// 查询
				query: {
					"size": 7,
					"page": 1,
									"product_name": "",
											"product_category": "",
															"login_time": "",
					"create_time": "",
					"orderby": `create_time desc`
				},

				// 数据
				list: [],
																																		message: '',
			}
		},
		methods: {
			// 关闭弹框
			closeModal(){
				this.showModal = false;
				},
			/**
			 * @description 获取到列表事件
			 * @param {Object} res 响应结果
			 */
			get_list_after: function get_list_after(res, func, url) {
				let _this = this
													_this.list.map((item) => {
					let param = {
						source_table: "commodity_information",
						source_id: item.commodity_information_id,
						source_user_id: _this.user.user_id
					};
					if(item.sales_information_limit_times > 0){
						_this.$get("~/api/sales_information/count?",param,(result)=>{
							if(result){
								if(result.result >= item.sales_information_limit_times){
									_this.$set(item,'sales_information_limit',true);
								}else{
									_this.$set(item,'sales_information_limit',false);
								}
							}
						})
					}else{
						_this.$set(item,'sales_information_limit',false);
					}
					Object.assign(item, param)
				})
								_this.list.map((item) => {
					let param = {
						source_table: "commodity_information",
						source_id: item.commodity_information_id,
						source_user_id: _this.user.user_id
					};
					if(item.purchasing_information_limit_times > 0){
						_this.$get("~/api/purchasing_information/count?",param,(result)=>{
							if(result){
								if(result.result >= item.purchasing_information_limit_times){
									_this.$set(item,'purchasing_information_limit',true);
								}else{
									_this.$set(item,'purchasing_information_limit',false);
								}
							}
						})
					}else{
						_this.$set(item,'purchasing_information_limit',false);
					}
					Object.assign(item, param)
				})
								_this.list.map((item) => {
					let param = {
						source_table: "commodity_information",
						source_id: item.commodity_information_id,
						source_user_id: _this.user.user_id
					};
					if(item.inventory_information_limit_times > 0){
						_this.$get("~/api/inventory_information/count?",param,(result)=>{
							if(result){
								if(result.result >= item.inventory_information_limit_times){
									_this.$set(item,'inventory_information_limit',true);
								}else{
									_this.$set(item,'inventory_information_limit',false);
								}
							}
						})
					}else{
						_this.$set(item,'inventory_information_limit',false);
					}
					Object.assign(item, param)
				})
																																																																},

																				



																						},
				created() {
										// 临时调试：打印当前路由权限对象（path、get、field_get/filed_get）
										try {
											const path = this.$route.path;
											const auth = this.$get_power ? this.$get_power(path) : (this.$store && this.$store.state && this.$store.state.web && this.$store.state.web.auth ? this.$store.state.web.auth.find(a=>a.path===path) : null);
											console.log('[DEBUG] commodity_information auth for path:', path, auth);
											if (auth) {
												console.log('[DEBUG] auth.get=', auth.get, 'field_get=', auth.field_get, 'fieldGet=', auth.fieldGet, 'filed_get=', auth.filed_get);
											} else {
												console.log('[DEBUG] no auth found for path', path, 'store.web.auth=', this.$store && this.$store.state ? this.$store.state.web.auth : null);
											}
										} catch (e) {
											console.error('[DEBUG] error reading auth', e);
										}
									},
	}
</script>

<style type="text/css">
	.bg {
		background: white;
	}

	.form.p_4 {
		padding: 1rem;
	}

	.form .el-input {
		width: initial;
	}

	.mt {
		margin-top: 1rem;
	}

	.text_center {
		text-align: center;
	}

	.float-right {
		float: right;
	}


	.modal_wrap{
		width: 100vw;
		height: 100vh;
		position: fixed;
		top: 0;
		left: 0;
		background: rgba(0,0,0,0.5);
		z-index: 9999999999;
	}
	.modal_wrap .modal_box{
		width: 400px;
		height: auto;
		background: url("../../assets/modal_bg.jpg") no-repeat center;
		background-size: cover;
		position: absolute;
		top: 50%;
		left: 50%;
		margin-left: -200px;
		margin-top: -100px;
		border-radius: 10px;
		padding: 10px;
		}
	.modal_wrap .modal_box .modal_box_close{
		font-size: 20px;
		position: absolute;
		top: 10px;
		right: 10px;
		cursor: pointer;
		}
	.modal_wrap .modal_box .modal_box_title{
	  text-align: center;
    font-size: 18px;
    margin: 16px auto;
    color: #fff;
    border-bottom: 1px solid rgba(117, 116, 116,0.5);
    padding-bottom: 16px;
    width: 356px;
		}
	.modal_wrap .modal_box .modal_box_text{
		text-align: center;
		font-size: 14px;
		color: #fff;
		margin: 5px auto;
		width: 90%;
		}
	.modal_wrap .modal_box .btn_box{
		display: flex;
		flex-direction: row;
		justify-content: center;
		margin-top: 42px;
		margin-bottom: 20px;
		}
			.modal_wrap .modal_box .btn_box span{
				display: inline-block;
				width: 80px;
				height: 30px;
				line-height: 30px;
				text-align: center;
				border: 1px solid #ccc;
				font-size: 14px;
				cursor: pointer;
				color: #fff;
			}
	.modal_wrap .modal_box .btn_box span:nth-child(2){
		background: #409EFF;
		color: #fff;
		border-color: #409EFF;
		margin-left: 15px;
	}
	.el-date-editor .el-range-separator{
		width: 10% !important;
	}
</style>
