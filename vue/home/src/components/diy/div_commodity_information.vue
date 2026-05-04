<template>
	<div class="diy_details_box diy_div_commodity_information">
		<div class="warp diy_warp">
			<div class="container">
					<div class="details_title">详情</div>
				<div class="row row_det">
						<div class="row_top_wrap">
						<!-- 图片 -->
							<div class="row_1" v-if="imgList.length">
									<div class="diy_img" v-for="(item,index) in imgList" :key="item+index">
									<img :src="$fullUrl(obj[item.name])" />
								</div>
								<!-- 点赞与收藏按钮 -->
								<div class="uc-image-actions" v-if="this.$store.state.user.user_id">
									<div class="uc-action-item" @click="change_praise()" :class="{active: state_praise}">
										<b-icon :icon="state_praise ? 'hand-thumbs-up-fill' : 'hand-thumbs-up'"></b-icon>
										<span>{{ state_praise ? '已点赞' : '点赞' }} ({{ praiseLen }})</span>
									</div>
									<div class="uc-action-item" @click="change_collect()" :class="{active: state_collect}">
										<b-icon :icon="state_collect ? 'heart-fill' : 'heart'"></b-icon>
										<span>{{ state_collect ? '已收藏' : '收藏' }}</span>
									</div>
								</div>
							</div>
							<!-- 内容 -->
							<div class="row_2" :class="{flex_row2: !imgList.length}">
							<div class="row_cont" :class="{flex_row2_item: !imgList.length}" v-for="(item,index) in itemList" :key="item+index" v-show="$check_field('get',item.name)">
								<div class="view">
								<div class="diy_title">
									<span>{{item.title}}:</span>
								</div>

								<div class="diy_field diy_uid" :class="{flex_row2_item_text:imgList.length}" v-if="item.type == 'UID'">
									<span>
										{{ get_user_info(item.name,obj[item.name]) }}
									</span>
								</div>
								<div class="diy_field diy_video" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '视频'">
									<router-link :to="'/media/video?filename=' + $fullUrl(obj[item.name])" v-if="obj[item.name]" >
										<span>
											查看视频
										</span>
									</router-link>
								</div>
								<div class="diy_field diy_music" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '音频'">
									<audio v-if="obj[item.name]" style="text-align: left" :src="$fullUrl(obj[item.name])" controls></audio>
								</div>
								<div class="diy_field diy_music" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '文件'">
									<a :href="$fullUrl(obj[item.name])" target="_blank" style="color: rgb(64, 158, 255);">点击下载</a>
								</div>
								<div class="diy_field diy_date" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '日期' || item.type == '日后'">
									<span>
										{{ $toTime(obj[item.name] ,"yyyy-MM-dd") }}
									</span>
								</div>
								<div class="diy_field diy_time" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '时间'">
									<span>
										{{ $toTime(obj[item.name] ,"hh:mm:ss") }}
									</span>
								</div>
								<div class="diy_field diy_datetime" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '日长'">
									<span>
										{{ $toTime(obj[item.name] ,"yyyy-MM-dd hh:mm:ss") }}
									</span>
								</div>
								<div class="diy_field diy_phone" :class="{flex_row2_item_text:imgList.length}"  v-else-if="item.type == '电话' || item.type == '手机'">
									<span>
										{{ obj[item.name] }}
									</span>
								</div>
								<div class="diy_field diy_number" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '数字'">
									<span>
										{{ obj[item.name] }}
									</span>
								</div>
								<div class="diy_field diy_url" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '网址'">
									<div>
										<a :href="obj[item.name]" target="_blank" style="color: rgb(64, 158, 255);">{{ obj[item.name] }}</a>
									</div>
								</div>
								<div class="diy_field diy_multiple_img" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '图集'">
									<div>
										<el-image class="diy_multiple_img_item"
											:src="img" v-for="img in obj[item.name]" :preview-src-list="obj[item.name]">
											<div slot="error" class="image-slot">
												<img src="../../../public/img/error.png" style="width: 90px; height: 90px" />
											</div>
										</el-image>
									</div>
								</div>
								<div class="diy_field diy_desc" :class="{flex_row2_item_text:imgList.length}" v-else-if="item.type == '多文本'">
									<div>
										{{ obj[item.name] }}
									</div>
								</div>
								<!-- <div class="diy_field diy_html"  v-else-if="item.type == '编辑'" v-html="obj[item.name]" >

								</div> -->
								<div class="diy_field diy_text" :class="{flex_row2_item_text:imgList.length}" v-else>
									<span>
										{{ obj[item.name] }}
									</span>
								</div>
							
							</div>
						</div>
															<div class="view praise_wrap">
									<span class="diy_title">点赞数：</span>	<span class="diy_field diy_text">
									{{ praiseLen }}
									</span>
								</div>
																						<div class="view praise_wrap">
									<span class="diy_title">点击数：</span>	<span class="diy_field diy_text">
									{{ viewsLen }}
									</span>
								</div>
																				</div>
					</div>

			<div class="details_btn_wrap">
				<button class="btn btn-primary details_btn" v-if="$check_action('/sales_information/edit','add') && !sales_information_limit" @click="to_form('/sales_information/edit')" ><span> 销售</span> </button>
				<button class="btn btn-primary details_btn" v-if="$check_action('/purchasing_information/edit','add') && !purchasing_information_limit" @click="to_form('/purchasing_information/edit')" ><span> 采购</span> </button>
				<button class="btn btn-primary details_btn" v-if="$check_action('/inventory_information/edit','add') && !inventory_information_limit" @click="to_form('/inventory_information/edit')" ><span> 库存</span> </button>
			</div>
						<!-- 富文本 -->
			<div class="rich_text" v-for="(item,index) in richList" :key="item+index" v-show="$check_field('get',item.name)">
						<div class="view">
						<div class="diy_title">
							<span v-text="item.title"></span>
						</div>
							<div class="diy_html" v-html="obj[item.name]" >

						</div>
						</div>
			</div>

				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from "@/mixins/component.js";
	import mixinPage from "@/mixins/page.js";

	export default {
		mixins: [mixin,mixinPage],
		components: {

		},
		props: {
			obj: {
				type: Object,
				default: function() {
					return {};
				},
			}
		},
		data() {
			return {
				praiseLen: this.obj["praise_len"],
				viewsLen: this.obj["views"],
				imgList: [
						{
							title: "商品图片",
							name: "product_images",
							type: "图片"
						},
				],
				itemList: [
						{
							title: "商品编码",
							name: "product_code",
							type: "文本"
						},
						{
							title: "商品名称",
							name: "product_name",
							type: "文本"
						},
						{
							title: "商品类别",
							name: "product_category",
							type: "文本"
						},
						{
							title: "商品品牌",
							name: "product_brand",
							type: "文本"
						},
						{
							title: "商品规格",
							name: "commodity_specifications",
							type: "文本"
						},
						{
							title: "商品库存",
							name: "product_inventory",
							type: "数字"
						},
						{
							title: "商品价格",
							name: "commodity_price",
							type: "数字"
						},
				],
				richList: [
						{
							title: "商品介绍",
							name: "product_introduction",
							type: "多文本"
						},
						{
							title: "商品详情",
							name: "product_details",
							type: "编辑"
						},
				],
														state_praise:false,
				state_collect:false,
							sales_information_limit: false,
						purchasing_information_limit: false,
						inventory_information_limit: false,
						};
		},
		methods: {
													get_user_info(name,id){
				var obj = null;
														var ret = "";
				if(obj){
					ret = obj.nick_name+"-"+obj.user_name;
					// if(obj.nick_name){
					// 	ret = obj.nick_name;
					// }
					// else{
					// 	ret = obj.user_name;
					// }
				}
				return ret;
			},
				/**
			 * 改变点赞数
			 */
			change_praise(obj) {
				var user_id = this.user.user_id;

				var query = {
					source_table: "commodity_information",
					source_field: "commodity_information_id",
					source_id: this.obj["commodity_information_id"],
					user_id
				};

				var _this = this;

				// 点赞状态
				if (this.state_praise) {
					this.state_praise = false;
					this.$get('~/api/praise/del?', query, (res) => {
						if(res.result){
              _this.praiseLen = parseInt(_this.praiseLen)-1;
              var praise_len = _this.praiseLen;
							this.$post('~/api/commodity_information/set?commodity_information_id=' + _this.obj["commodity_information_id"], {
								praise_len
							}, (res) => {
								if(res.result){
									console.log("添加点赞数状态：" ,res.result);
								}
								else if(res.error){
									console.error(res.error);
								}
							});
							// this.$toast("取消点赞");
							this.$message.success("取消点赞")
						}
						else if (res.error){
							this.$toast(res.error.message);
							console.error(res.error);
						}
					});
				} else {
					this.state_praise = true;
					this.$post('~/api/praise/add?', query, (res) => {
						if (res.result) {
              _this.praiseLen = parseInt(_this.praiseLen)+1;
              var praise_len = _this.praiseLen;
							this.$post('~/api/commodity_information/set?commodity_information_id=' + _this.obj["commodity_information_id"], {
								praise_len
							}, (res) => {
								if(res.result){
									console.log("添加点赞数状态：" ,res.result);
								}
								else if(res.error){
									console.error(res.error);
								}
							});
							// this.$toast("点赞成功");
							this.$message.success("点赞成功")
						}
						else if (res.error) {
							this.$toast(res.error.message);
							console.error(res.error);
						}
					});
				};
			},
      /**
       * 获取点赞
       */
      get_praise() {
        var user_id = this.$store.state.user.user_id;
        this.$get("~/api/praise/count?", {
          source_table: "commodity_information",
          source_field: "commodity_information_id",
          source_id: this.obj.commodity_information_id,
          user_id
        }, (res) => {
          if (res.result || res.result === 0) {
            console.log("sadsfasf"+JSON.stringify(res))
            this.state_praise = res.result ? true : false;
            console.log("点赞状态：" ,this.state_praise);
          }
          else if (res.error){
            this.$toast(res.error.message);
            console.error(res.error);
          }
        })
      },

				/**
			 * 改变收藏状态
			 */
			change_collect() {
				var user_id = this.user.user_id;

				var query = {
					source_table: "commodity_information",
					source_field: "commodity_information_id",
					source_id: this.obj["commodity_information_id"],
					user_id
				};

				// 收藏状态
				if (this.state_collect) {
					this.state_collect = false;
					this.$get('~/api/collect/del?', query, (res) => {
						if(res.result){
							// this.$toast("取消收藏");
							this.$message.success("取消收藏")
						}
						else if (res.error){
							this.$toast(res.error.message);
							console.error(res.error);
						}
					});
				} else {
					this.state_collect = true;
													query.title = this.obj.product_name
																																		query.img = this.obj.product_images
																							this.$post('~/api/collect/add?', query, (res) => {
						if (res.result) {
							// this.$toast("收藏成功");
							this.$message.success("收藏成功")
						}
						else if (res.error) {
							this.$toast(res.error.message);
							console.error(res.error);
						}
					});
				};
			},
      check_collect() {
        var user_id = this.$store.state.user.user_id;
        var commodity_information_id = this.obj.commodity_information_id;
        this.$get('~/api/collect/count?', {
          user_id,
          source_table: "commodity_information",
          source_field: "commodity_information_id",
          source_id: commodity_information_id
        }, (res) => {
          this.state_collect = res.result
        });
      },
			  get_sales_information_limit(){
	  	let param = {
	  		source_table: "commodity_information",
	  		source_id: this.obj.commodity_information_id,
	  		source_user_id: this.user.user_id
	  	};
	  	if(this.obj.sales_information_limit_times > 0){
	  		this.$get("~/api/sales_information/count?",param,(result)=>{
	  			if(result){
	  				if(result.result >= this.obj.sales_information_limit_times){
	  					this.sales_information_limit = true;
	  				}else{
	  					this.sales_information_limit = false;
	  				}
	  			}
	  		})
	  	}else{
	  		this.sales_information_limit = false;
	  	}
		this.obj.source_table = param.source_table;
		this.obj.source_id = param.source_id;
		this.obj.source_user_id = param.source_user_id;
	  },
		  get_purchasing_information_limit(){
	  	let param = {
	  		source_table: "commodity_information",
	  		source_id: this.obj.commodity_information_id,
	  		source_user_id: this.user.user_id
	  	};
	  	if(this.obj.purchasing_information_limit_times > 0){
	  		this.$get("~/api/purchasing_information/count?",param,(result)=>{
	  			if(result){
	  				if(result.result >= this.obj.purchasing_information_limit_times){
	  					this.purchasing_information_limit = true;
	  				}else{
	  					this.purchasing_information_limit = false;
	  				}
	  			}
	  		})
	  	}else{
	  		this.purchasing_information_limit = false;
	  	}
		this.obj.source_table = param.source_table;
		this.obj.source_id = param.source_id;
		this.obj.source_user_id = param.source_user_id;
	  },
		  get_inventory_information_limit(){
	  	let param = {
	  		source_table: "commodity_information",
	  		source_id: this.obj.commodity_information_id,
	  		source_user_id: this.user.user_id
	  	};
	  	if(this.obj.inventory_information_limit_times > 0){
	  		this.$get("~/api/inventory_information/count?",param,(result)=>{
	  			if(result){
	  				if(result.result >= this.obj.inventory_information_limit_times){
	  					this.inventory_information_limit = true;
	  				}else{
	  					this.inventory_information_limit = false;
	  				}
	  			}
	  		})
	  	}else{
	  		this.inventory_information_limit = false;
	  	}
		this.obj.source_table = param.source_table;
		this.obj.source_id = param.source_id;
		this.obj.source_user_id = param.source_user_id;
	  },
			  },
		created() {
										      setTimeout(() => {
        this.get_praise();
        this.check_collect();
				this.get_sales_information_limit();
			this.get_purchasing_information_limit();
			this.get_inventory_information_limit();
		      }, 1000);
		},
		watch:{
			obj:{
				deep: true,
				handler(newVal){
					this.praiseLen = this.obj["praise_len"]
					this.viewsLen = this.obj["views"]
																			}
			},
		},
	};
</script>

<style>
.uc-image-actions {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 15px;
	padding-bottom: 10px;
}

.uc-action-item {
	display: flex;
	align-items: center;
	gap: 6px;
	cursor: pointer;
	padding: 6px 15px;
	border-radius: 20px;
	font-size: 14px;
	transition: all 0.3s;
	background: #f8fbff;
	border: 1px solid #eef4fa;
	color: #64748b;
}

.uc-action-item:hover {
	background: #fff;
	box-shadow: 0 4px 10px rgba(0,0,0,0.05);
	transform: translateY(-1px);
}

.uc-action-item.active {
	background: #1a6fa8;
	color: #fff;
	border-color: #1a6fa8;
}

.uc-action-item.active:hover {
	background: #165b86;
}

.uc-action-item:nth-child(2).active {
	background: #ef4444;
	border-color: #ef4444;
}

.uc-action-item:nth-child(2).active:hover {
	background: #dc2626;
}

.collect_btn,
.praise_btn {
	margin-right: 0.5rem;
	display: flex;
	white-space: nowrap;
	padding: 0.125rem 0.5rem;
	border-radius: 0.25rem;
	color: var(--color_base);
	border: 1px solid var(--color_default);
	cursor: pointer;
}

.icon_change {
	color: var(--color_base);
}

.collect_btn:hover {
	border: 1px solid var(--color_base);
	color: var(color_base);
}

.praise_btn:hover {
	border: 1px solid var(color_base);
	color: var(--color_base);
}
.icon {
	font-size: 15px;
	margin: 3px;
}
.word_change {
	color: var(--color_base);
	font-weight: bold;
}
#app .diy_details_box .warp .container .row .btns_add{
	margin-left: 20px;
}
.btns_add {
	display: flex;
	justify-content: flex-start;
	align-items: center;
	flex-wrap: wrap;
	margin: 0 0.625rem 0.625rem 0;
	font-size: 0.875rem;
	-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	color: rgba(0, 0, 0, 0.3);
}
.btns_add > * {
	display: flex;
	align-items: center;
	height: 2rem;
}
.diy_multiple_img{
	width: 100%;
}
.diy_multiple_img_item{
	float: left;
	margin: 0 10px 10px 0;
}
.diy_multiple_img_item img{
	height: 100px;
	width: auto;
}
</style>
