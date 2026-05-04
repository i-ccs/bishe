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
					<el-col :xs="24" :sm="12" :lg="6">
						<el-form-item label="支付状态">
							<el-select v-model="query.pay_state" style="width: 100%">
								<el-option value="">全部状态</el-option>
								<el-option value="未支付">未支付</el-option>
								<el-option value="已支付">已支付</el-option>
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
				<router-link v-if="$check_action('/sales_information/view','add')" to="./view" class="el-button el-button--primary">
					<i class="el-icon-plus"></i> 新增销售单
				</router-link>
				<el-button v-if="$check_action('/sales_information/table','del') || $check_action('/sales_information/view','del')" 
					type="danger" @click="delInfo()" icon="el-icon-delete" :disabled="selection.length === 0">批量删除</el-button>
			</div>

			<el-table :data="list" @selection-change="selectionChange" @sort-change="$sortChange" style="width: 100%" class="premium-table" stripe>
				<el-table-column align="center" fixed type="selection" width="55"></el-table-column>
				<el-table-column align="center" prop="product_code" label="商品编码" v-if="$check_field('get','product_code')" min-width="140"></el-table-column>
				<el-table-column align="center" prop="product_name" label="商品名称" v-if="$check_field('get','product_name')" min-width="150"></el-table-column>
				<el-table-column align="center" prop="product_category" label="商品类别" v-if="$check_field('get','product_category')" min-width="100"></el-table-column>
				<el-table-column align="center" prop="product_brand" label="商品品牌" v-if="$check_field('get','product_brand')" min-width="100"></el-table-column>
				<el-table-column align="center" prop="commodity_price" label="商品价格" v-if="$check_field('get','commodity_price')" min-width="100">
					<template slot-scope="scope">¥ {{scope.row.commodity_price}}</template>
				</el-table-column>
				<el-table-column align="center" prop="sales_order_number" label="销售单号" v-if="$check_field('get','sales_order_number')" min-width="150"></el-table-column>
				<el-table-column align="center" prop="registered_user" label="下单用户" v-if="$check_field('get','registered_user')" min-width="140">
					<template slot-scope="scope">{{ get_user_registered_user(scope.row['registered_user']) }}</template>
				</el-table-column>
				<el-table-column align="center" prop="order_quantity" label="数量" v-if="$check_field('get','order_quantity')" width="80"></el-table-column>
				<el-table-column align="center" prop="total_order_price" label="实付总额" v-if="$check_field('get','total_order_price')" min-width="120">
					<template slot-scope="scope"><span style="color: #f56c6c; font-weight: 600;">¥ {{scope.row.total_order_price}}</span></template>
				</el-table-column>
				<el-table-column align="center" label="支付状态" prop="pay_state" width="100">
					<template slot-scope="scope">
						<el-tag :type="scope.row.pay_state === '已支付' ? 'success' : 'danger'" size="mini">{{scope.row.pay_state}}</el-tag>
					</template>
				</el-table-column>
				<el-table-column align="center" prop="create_time" label="销售时间" min-width="160">
					<template slot-scope="scope">{{ $toTime(scope.row["create_time"],"yyyy-MM-dd hh:mm") }}</template>
				</el-table-column>

				<el-table-column align="center" fixed="right" label="操作" min-width="120">
					<template slot-scope="scope">
						<router-link class="el-button el-button--primary el-button--mini is-plain" :to="'./view?' + field + '=' + scope.row[field]">详情</router-link>
						<el-button class="el-button el-button--success el-button--mini is-plain" @click="openPayModal(scope.row)" v-if="scope.row.pay_state==='未支付' && ($check_pay('/sales_information/table'))">支付</el-button>
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

		<el-dialog title="订单支付" :visible.sync="payModalVisible" width="500px">
			<el-tabs v-model="pay_obj.payActiveName" :stretch="true">
				<el-tab-pane label="微信支付" name="微信">
					<div style="text-align: center; padding: 20px;">
						<el-image style="width: 200px; height: 200px; margin-bottom: 20px;" :src="require('../../../public/wx.png')"></el-image>
						<el-button type="primary" style="width: 100%;" @click="submitPay()">确认已扫码支付</el-button>
					</div>
				</el-tab-pane>
				<el-tab-pane label="支付宝支付" name="支付宝">
					<div style="text-align: center; padding: 20px;">
						<el-image style="width: 200px; height: 200px; margin-bottom: 20px;" :src="require('../../../public/alipay.png')"></el-image>
						<el-button type="primary" style="width: 100%;" @click="submitPay()">确认已扫码支付</el-button>
					</div>
				</el-tab-pane>
				<el-tab-pane label="网上银行" name="网银">
					<div style="padding: 20px;">
						<el-form label-position="top">
							<el-form-item label="网银账号">
								<el-input v-model="pay_obj.account" placeholder="请输入您的网银账号"></el-input>
							</el-form-item>
							<el-form-item label="支付密码">
								<el-input placeholder="请输入6位支付密码" v-model="pay_obj.password" show-password maxlength="6"></el-input>
							</el-form-item>
							<el-button type="primary" style="width: 100%; margin-top: 20px;" @click="submitPay()">立即支付</el-button>
						</el-form>
					</div>
				</el-tab-pane>
			</el-tabs>
		</el-dialog>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				showModal: false,
				url_get_list: "~/api/sales_information/get_list?like=0",
				url_del: "~/api/sales_information/del?",
				field: "sales_information_id",
				query: {
					"size": 7,
					"page": 1,
					"product_name": "",
					"product_category": "",
					"pay_state":"",
					"orderby": `create_time desc`
				},
				list: [],
				payModalVisible:false,
				pay_obj:{ payActiveName:"微信", account:"", password:"", id:"" },
				list_user_registered_user: [],
				message: '',
			}
		},
		methods: {
			closeModal(){ this.showModal = false; },
			get_list_before(param){
				var user_group = this.user.user_group;
				if(user_group != "管理员"){
					let sqlwhere = "(";
					if(user_group=="注册用户"){ sqlwhere+= "registered_user = " + this.user.user_id + " or "; }
					if (sqlwhere.length>1){
						sqlwhere = sqlwhere.substr(0,sqlwhere.length-4);
						sqlwhere += ")";
						param["sqlwhere"] = sqlwhere;
					}
				}
				return param;
			},
			async get_list_user_registered_user() {
				var json = await this.$get("~/api/user/get_list?user_group=注册用户");
				if(json.result && json.result.list){ this.list_user_registered_user = json.result.list; }
			},
			get_user_registered_user(id){
				var obj = this.list_user_registered_user.getObj({"user_id":id});
				return obj ? (obj.nick_name + " (" + obj.user_name + ")") : id;
			},
			openPayModal(v){
				this.pay_obj.id = v.sales_information_id
				this.payModalVisible = true
			},
			submitPay(){
				let _this = this;
				if(_this.pay_obj.payActiveName == "网银"){
					if(!_this.pay_obj.account || _this.pay_obj.password.length < 6){
						return _this.$toast("请完善支付信息", 'danger');
					}
				}
				let url = this.$toUrl(this.query, "~/api/sales_information/set?sales_information_id="+this.pay_obj.id);
				let param = {"pay_state":"已支付","pay_type":this.pay_obj.payActiveName}
				this.$post(url, param, function(json, status) {
					if (json.result) {
						_this.$toast('支付成功！', 'success');
						_this.payModalVisible = false;
						_this.get_list();
					}
				});
			},
		},
		created() { this.get_list_user_registered_user(); }
	}
</script>

<style scoped>
</style>
