<template>
	<el-main class="bg edit_wrap comtable_e">
		<el-card class="premium-view-card" shadow="never" v-if="is_view()">
			<div slot="header" class="premium-header">
				<span class="premium-title">库存核对详情</span>
				<span class="premium-subtitle">实时监控商品库存状态，记录核对日期与实际余量</span>
			</div>

			<el-form ref="form" :model="form" status-icon label-width="120px" label-position="top">
				<div class="premium-section-title">商品基本信息</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_code') || $check_field('add','prod_code') || $check_field('set','prod_code')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品编码" prop="prod_code">
							<el-select id="prod_code" v-model="form['prod_code']" placeholder="请选择商品编码" style="width:100%" filterable
								v-if="(form['invent_info_id'] && $check_field('set','prod_code')) || (!form['invent_info_id'] && $check_field('add','prod_code'))"
								@change="on_prod_code_change" :disabled="disabledObj['prod_code_isDisabled']">
								<el-option v-for="item in list_commodity" :key="item.prod_code" :label="item.prod_code" :value="item.prod_code"></el-option>
							</el-select>
							<div v-else-if="$check_field('get','prod_code')" class="premium-readonly-field">{{form['prod_code']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_name') || $check_field('add','prod_name') || $check_field('set','prod_name')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品名称" prop="prod_name">
							<div class="premium-readonly-field">{{form['prod_name'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','prod_category') || $check_field('add','prod_category') || $check_field('set','prod_category')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="商品类别" prop="prod_category">
							<div class="premium-readonly-field">{{form['prod_category'] || '请先选择商品编码'}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-section-title">库存核对记录</div>
				<el-row :gutter="20">
					<el-col v-if="$check_field('get','prod_inventory') || $check_field('add','prod_inventory') || $check_field('set','prod_inventory')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="系统账面库存" prop="prod_inventory">
							<div class="premium-readonly-field">{{form['prod_inventory'] !== 0 ? form['prod_inventory'] : ('请先选择商品编码')}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','check_date') || $check_field('add','check_date') || $check_field('set','check_date')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="最近核对日期" prop="check_date">
							<el-date-picker :disabled="disabledObj['check_date_isDisabled']" style="width: 100%"
								v-if="(form['invent_info_id'] && $check_field('set','check_date')) || (!form['invent_info_id'] && $check_field('add','check_date'))" id="check_date"
								v-model="form['check_date']" type="date" placeholder="选择日期" :picker-options="check_date_disableOptions" value-format="yyyy-MM-dd">
							</el-date-picker>
							<div v-else-if="$check_field('get','check_date')" class="premium-readonly-field">{{form['check_date']}}</div>
						</el-form-item>
					</el-col>
					<el-col v-if="$check_field('get','check_quant') || $check_field('add','check_quant') || $check_field('set','check_quant')" :xs="24" :sm="12" :lg="8">
						<el-form-item label="实际盘点数量" prop="check_quant">
							<el-input-number id="check_quant" v-model.number="form['check_quant']" style="width: 100%" :min="0"
								v-if="(form['invent_info_id'] && $check_field('set','check_quant')) || (!form['invent_info_id'] && $check_field('add','check_quant'))" :disabled="disabledObj['check_quant_isDisabled']"></el-input-number>
							<div v-else-if="$check_field('get','check_quant')" class="premium-readonly-field">{{form['check_quant']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<el-row :gutter="20">
					<el-col v-if="$check_field('get','inventory') || $check_field('add','inventory') || $check_field('set','inventory')" :xs="24" :sm="24" :lg="24">
						<el-form-item label="库存变动情况说明" prop="inventory">
							<el-input type="textarea" :rows="4" id="inventory" v-model="form['inventory']" placeholder="请输入库存变动、损耗或其他异常说明..."
								v-if="(form['invent_info_id'] && $check_field('set','inventory')) || (!form['invent_info_id'] && $check_field('add','inventory'))" :disabled="disabledObj['inventory_isDisabled']"></el-input>
							<div v-else-if="$check_field('get','inventory')" class="premium-readonly-field" style="min-height: 80px;">{{form['inventory']}}</div>
						</el-form-item>
					</el-col>
				</el-row>

				<div class="premium-actions">
					<template v-if="$check_action('/inventory_information/view','set') || $check_action('/inventory_information/view','add')">
						<el-button type="primary" class="premium-btn-submit" @click="submit()" icon="el-icon-check">提交更新</el-button>
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
				field: "invent_info_id",
				url_add: "~/api/inventory_information/add?",
				url_set: "~/api/inventory_information/set?",
				url_get_obj: "~/api/inventory_information/get_obj?",
				url_upload: "~/api/inventory_information/upload?",
				query: { "invent_info_id": 0 },
				form: {
					"prod_code":  '', // 商品编码
					"prod_name":  '', // 商品名称
					"prod_category":  '', // 商品类别
					"prod_brand":  '', // 商品品牌
					"prod_inventory":  0, // 商品库存
					"check_date":  '', // 核对日期
					"check_quant":  0, // 核对数量
					"inventory":  '', // 库存情况
					"invent_info_id": 0, // ID
				},
				disabledObj:{
					"prod_code_isDisabled": false,
					"prod_name_isDisabled": false,
					"prod_category_isDisabled": false,
					"prod_brand_isDisabled": false,
					"prod_inventory_isDisabled": false,
					"check_date_isDisabled": false,
					"check_quant_isDisabled": false,
					"inventory_isDisabled": false,
				},
				check_date_disableOptions: {
					disabledDate(time) {
						return time.getTime() < Date.now() - 8.64e7;
					},
				},
				list_commodity: [],
			}
		},
		methods: {
			async get_list_commodity() {
				var json = await this.$get("~/api/commodity_information/get_list?size=1000");
				if(json.result && json.result.list){
					this.list_commodity = json.result.list;
				} else if(json.error){
					console.error(json.error);
				}
			},
			on_prod_code_change(code) {
				var item = this.list_commodity.find(c => (c.prod_code === code || c.prod_code === code));
				if (item) {
					this.form.prod_name = item.prod_name || item.prod_name;
					this.form.prod_category = item.prod_category || item.prod_category;
					this.form.prod_brand = item.prod_brand || item.prod_brand;
					this.form.prod_inventory = item.prod_inventory || item.prod_invent;
				}
			},
			get_obj_before(param) {
				var form = $.db.get("form");
				$.push(this.form ,form);
				if(this.form && form){
					Object.keys(this.form).forEach(key => {
						Object.keys(form).forEach(dbKey => {
							if(key === dbKey){
								this.disabledObj[key+'_isDisabled'] = true;
								this.form[key] = form[dbKey]
							}
							if(dbKey === "sou_table"){ this.form['sou_table'] = form[dbKey]; }
							if(dbKey === "sou_id"){ this.form['sou_id'] = form[dbKey]; }
							if(dbKey === "sou_user_id"){ this.form['sou_user_id'] = form[dbKey]; }
						})
					})
				}
				if (this.form["check_date"] && JSON.stringify(this.form["check_date"]).indexOf("-")===-1){
					this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
				}
				$.db.del("form");
				return param;
			},
			get_obj_after(json, func){
				if(this.form["check_date"]=="0000-00-00"){
				  this.form["check_date"] = null;
				}
				if(parseInt(this.form["check_date"]) > 9999){
					this.form["check_date"] = this.$toTime(parseInt(this.form["check_date"]),"yyyy-MM-dd")
				}
			},
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
				if (!param.prod_code || param.prod_code.trim() === '') {
					return '商品编码不能为空，请从下拉列表中选择';
				}
				console.log('开始验证库存数据:', param);
				
				// 验证核对日期
				if (!param.check_date){ 
					console.log('验证失败：核对日期为空');
					return "核对日期不能为空"; 
				}
				
				// 验证系统账面库存不能小于0
				if (param.prod_inventory === null || param.prod_inventory === undefined || param.prod_inventory < 0) {
					console.log('验证失败：系统账面库存无效', param.prod_inventory);
					return '系统账面库存不能小于0';
				}
				
				// 验证实际盘点数量不能小于0
				if (param.check_quant === null || param.check_quant === undefined || param.check_quant < 0) {
					console.log('验证失败：实际盘点数量无效', param.check_quant);
					return '实际盘点数量不能小于0';
				}
				
				console.log('验证通过');
				return null;
			},
			is_view(){
				var bl = false;
				if(!bl){ bl = this.$check_action('/inventory_information/table','add'); }
				if(!bl){ bl = this.$check_action('/inventory_information/table','set'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','add'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','set'); }
				if(!bl){ bl = this.$check_action('/inventory_information/view','get'); }
				return bl;
			},
			submit_after(json, func) {
				this.$toast('提交成功！', 'success');
				if (this.form.sou_table === 'commodity_information') {
					this.$router.push('/commodity_information/table');
				} else {
					let path = this.$route.fullPath;
					this.$router.push(path.replace('/view', '/table'));
				}
			},
			uploadimg(param) { this.uploadFile(param.file, "avatar"); },
		},
		created() {
			this.get_list_commodity();
		},
	}
</script>

<style scoped>
</style>
