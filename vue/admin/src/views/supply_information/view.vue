<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">供应商详情</span>
				<span class="premium-subtitle">录入及更新供应商合作资质、供应频率及评价信息</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">供应商档案</div>
				<el-row :gutter="20">
					<el-col v-if="can_show_field('supplier_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="供应商名称" prop="supplier_name">
							<el-input id="supplier_name" v-model="form['supplier_name']" placeholder="请输入单位全称" prefix-icon="el-icon-office-building"
								v-if="can_edit_field('supplier_name')" :disabled="disabledObj['supplier_name_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field">{{form['supplier_name']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="can_show_field('suppliers_phone_number')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="联系电话" prop="suppliers_phone_number">
							<el-input id="suppliers_phone_number" v-model="form['suppliers_phone_number']" placeholder="请输入手机或座机" type="tel" prefix-icon="el-icon-phone"
								v-if="can_edit_field('suppliers_phone_number')"></el-input>
							<div v-else class="premium-readonly-field">{{form['suppliers_phone_number']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="can_show_field('commodity_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="主营类别" prop="commodity_category">
							<el-select id="commodity_category" v-model="form['commodity_category']" style="width: 100%" v-if="can_edit_field('commodity_category')">
								<el-option v-for="o in list_commodity_category" :key="o['product_category']" :label="o['product_category']" :value="o['product_category']"></el-option>
							</el-select>
							<div v-else class="premium-readonly-field">{{form['commodity_category']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="can_show_field('supply_frequency')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="供应频率" prop="supply_frequency">
							<el-input id="supply_frequency" v-model="form['supply_frequency']" placeholder="例：每周2次 / 按需" prefix-icon="el-icon-refresh"
								v-if="can_edit_field('supply_frequency')" :disabled="disabledObj['supply_frequency_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field">{{form['supply_frequency']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="can_show_field('comprehensive_evaluation')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="综合评价" prop="comprehensive_evaluation">
							<el-input id="comprehensive_evaluation" v-model="form['comprehensive_evaluation']" placeholder="请输入简短评价" prefix-icon="el-icon-star-off"
								v-if="can_edit_field('comprehensive_evaluation')" :disabled="disabledObj['comprehensive_evaluation_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field">{{form['comprehensive_evaluation']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">供应能力说明</div>
				<el-row :gutter="20">
					<el-col v-if="can_show_field('supply_products')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="主要供应产品" prop="supply_products">
							<el-input type="textarea" :rows="3" id="supply_products" v-model="form['supply_products']" placeholder="列举供应商提供的核心产品..."
								v-if="can_edit_field('supply_products')" :disabled="disabledObj['supply_products_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field" style="min-height: 60px;">{{form['supply_products']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="can_show_field('product_quality')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="质量管控情况" prop="product_quality">
							<el-input type="textarea" :rows="3" id="product_quality" v-model="form['product_quality']" placeholder="说明该供应商的产品质量表现..."
								v-if="can_edit_field('product_quality')" :disabled="disabledObj['product_quality_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field" style="min-height: 60px;">{{form['product_quality']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="can_show_field('cooperation_situation')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="历史合作备注" prop="cooperation_situation">
							<el-input type="textarea" :rows="3" id="cooperation_situation" v-model="form['cooperation_situation']" placeholder="记录过往合作中的亮点或问题..."
								v-if="can_edit_field('cooperation_situation')" :disabled="disabledObj['cooperation_situation_isDisabled']"></el-input>
							<div v-else class="premium-readonly-field" style="min-height: 60px;">{{form['cooperation_situation']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/supply_information/table','set') || $check_action('/supply_information/table','add') || $check_action('/supply_information/view','set') || $check_action('/supply_information/view','add')">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">保存供应商信息</el-button>
						<el-button class="premium-btn-cancel" @click="cancel()" icon="el-icon-close">取消</el-button>
					</template>
					<el-button v-else class="premium-btn-cancel" @click="cancel()" icon="el-icon-back">返回</el-button>
				</div>
			</el-form>
		</el-card>
	</el-main>
</template>

<script>
	import mixin from "@/mixins/page.js";
	export default {
		mixins: [mixin],
		data() {
			return {
				field: "supply_information_id",
				url_add: "~/api/supply_information/add?",
				url_set: "~/api/supply_information/set?",
				url_get_obj: "~/api/supply_information/get_obj?",
				url_upload: "~/api/supply_information/upload?",
				query: { "supply_information_id": 0 },
				form: {
					"supplier_name":  '', // 供应商名称
					"suppliers_phone_number":  '', // 供应商电话
					"commodity_category":  '', // 商品类别
					"comprehensive_evaluation":  '', // 综合评价
					"supply_frequency":  '', // 供应频率
					"supply_products":  '', // 供应产品
					"product_quality":  '', // 产品质量
					"cooperation_situation":  '', // 合作情况
					"supply_information_id": 0, // ID
				},
				disabledObj:{
					"supplier_name_isDisabled": false,
					"suppliers_phone_number_isDisabled": false,
					"commodity_category_isDisabled": false,
					"comprehensive_evaluation_isDisabled": false,
					"supply_frequency_isDisabled": false,
					"supply_products_isDisabled": false,
					"product_quality_isDisabled": false,
					"cooperation_situation_isDisabled": false,
				},
				list_commodity_category: [""],
			}
		},
		methods: {
			can_show_field(field_name){
				return this.$check_field('get', field_name) || this.$check_field('add', field_name) || this.$check_field('set', field_name)
					|| this.$check_action('/supply_information/table','add') || this.$check_action('/supply_information/table','set')
					|| this.$check_action('/supply_information/view','add') || this.$check_action('/supply_information/view','set') || this.$check_action('/supply_information/view','get');
			},
			can_edit_field(field_name){
				if(this.form['supply_information_id']){
					return this.$check_field('set', field_name) || this.$check_action('/supply_information/table','set') || this.$check_action('/supply_information/view','set');
				}
				return this.$check_field('add', field_name) || this.$check_action('/supply_information/table','add') || this.$check_action('/supply_information/view','add');
			},
			async get_list_commodity_category() {
				var json = await this.$get("~/api/commodity_information/get_list?");
				if(json.result && json.result.list){
					this.list_commodity_category = json.result.list;
				}
				else if(json.error){
					console.error(json.error);
				}
			},
			get_obj_before(param) {
				$.db.del("form");
				return param;
			},
			get_obj_after(json, func){},
			async submit(param, func){
				if (!param) { param = this.form; }
				var pm = this.events("submit_before", Object.assign({}, param)) || param;
				var msg = await this.events("submit_check", pm);
				var ret;
				if (msg) { this.$toast(msg, 'danger'); }
				else { ret = this.events("submit_main", pm, func); }
				return ret;
			},
			submit_check(param) {
				console.log('开始验证供应商数据:', param);
				
				// 验证供应商名称
				if (!param.supplier_name || param.supplier_name.trim() === '') {
					console.log('验证失败：供应商名称为空');
					return '供应商名称不能为空';
				}
				
				// 验证联系电话
				if (!param.suppliers_phone_number || param.suppliers_phone_number.trim() === '') {
					console.log('验证失败：联系电话为空');
					return '联系电话不能为空';
				}
				
				// 验证手机号格式
				let suppliers_phone_number_phone_regular = /^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\d{8}$/;
				if(param.suppliers_phone_number && !suppliers_phone_number_phone_regular.test(param.suppliers_phone_number)){
					console.log('验证失败：手机号格式错误');
					return "手机号格式错误";
				}
				
				// 验证主营类别不能为空
				if (!param.commodity_category || param.commodity_category.trim() === '') {
					console.log('验证失败：主营类别为空');
					return '主营类别不能为空';
				}
				
				// 验证供应频率
				if (!param.supply_frequency || param.supply_frequency.trim() === '') {
					console.log('验证失败：供应频率为空');
					return '供应频率不能为空';
				}
				
				console.log('验证通过');
				return null;
			},
			is_view(){
				var bl = false;
				if(!bl){ bl = this.$check_action('/supply_information/table','add'); }
				if(!bl){ bl = this.$check_action('/supply_information/table','set'); }
				if(!bl){ bl = this.$check_action('/supply_information/view','add'); }
				if(!bl){ bl = this.$check_action('/supply_information/view','set'); }
				if(!bl){ bl = this.$check_action('/supply_information/view','get'); }
				return bl;
			},
			uploadimg(param) { this.uploadFile(param.file, "avatar"); },
		},
		created() {
			this.get_list_commodity_category();
		},
	}
</script>

<style scoped>
</style>
