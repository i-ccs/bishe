<template>
	<div class="page_root" id="root_demo">
		<!-- Hero Section -->
		<div class="warp banner">
			<div class="container swiper_box">
				<!-- Centered Swiper Row -->
				<div class="row justify-content-center">
					<div class="col-lg-4 col-md-6 col-sm-12">
						<div class="premium-swiper-container">
							<div class="swiper_img premium-swiper">
								<swiper_img :list="list_slide"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Main Content Section (News & Products) -->
		<div class="home-section content_row">
			<div class="container">
				<!-- Top Row: News & Products -->
				<el-row>
					<el-col :span="24">
						<el-card class="unified-content-card">
							<el-row :gutter="40">
								<!-- Left: Featured Products (3/5) -->
								<el-col :lg="14" :md="14" :sm="24">
									<div class="content-column products-column">
										<div class="section-header mini">
											<div class="title">商品信息推荐</div>
											<router-link to="/commodity_information/list" class="more-link">更多 <i class="el-icon-arrow-right"></i></router-link>
										</div>
										<div class="list_commodity_information_box">
											<list_commodity_information :list="list_commodity_information" />
										</div>
									</div>
								</el-col>
								<!-- Right: Industry News (2/5) -->
								<el-col :lg="10" :md="10" :sm="24">
									<div class="content-column news-column">
										<div class="section-header mini">
											<div class="title">行业资讯</div>
											<router-link to="/article/list" class="more-link">更多 <i class="el-icon-arrow-right"></i></router-link>
										</div>
										<div class="list_article_box">
											<list_article v-if="show_list_article" :list="list_article" />
										</div>
									</div>
								</el-col>
							</el-row>
						</el-card>
					</el-col>
				</el-row>

			</div>
		</div>
	</div>
</template>

<script>
	import mixin from "@/mixins/page.js";
			import list_commodity_information from "@/components/diy/list_commodity_information.vue";
						import bar_title from "@/components/diy/bar_title.vue";
	import list_article from "@/components/diy/list_article.vue";
	import swiper_img from "@/components/diy/swiper_img.vue";

	export default {
		mixins: [mixin],
		components: {
					list_commodity_information,
								bar_title,
			list_article,
			swiper_img
		},
		data() {
			return {
				isSmall: false,
				sendValue: "",
				chatList:[],
				showChat: false,
				isAdmin: false,
				token:"",
				// 文章模型数组
				list_article: [],
				vm_arr_article: [
					"article_id",
					"img",
					"title",
					"praise_len",
					"views",
					"type",
					"create_time",
				],
				fields_article: [
					{key: "img", label: "图片", type: "图片"},
					{key: "title", label: "标题", type: "文本"},
					{key: "praise_len", label: "点赞数", type: "文本"},
					{key: "views", label: "点击量", type: "文本"},
					{key: "type", label: "分类", type: "文本"},
					{key: "create_time", label: "发布时间", type: "文本"},
				],
				show_list_article: true,
						list_commodity_information: [],
									list_slide: [],
				list_menu: [],
			};
		},
		created(){
			this.get_token();
		},
		methods: {
			getHashParams() {
				let key = "token";
				// / 获取所有参数
				let query = window.location.search.substring(1);
				let hash = window.location.hash.substring(1);
				// 如果锚点后面有参数，把锚点后面的参数加入到search参数中
				if(hash.indexOf("?") > -1){
					query += "&" + hash.split("?")[1];
				}
				let key_values = query.split("&");
				let params = {};
				// 遍历参数并存入params对象
				key_values.map(function (key_val){
					let key_val_arr = key_val.split("=");
					params[key_val_arr[0]] = key_val_arr[1];
				});
				// 如果找到了key对应的参数，返回对应值
				if(typeof params[key]!="undefined"){
					return params[key];
				}
				// 如果没找到，返回空字符串
				return "";
			},
			get_token(){
				// let token = this.$route.query.token
				let token = this.getHashParams();
				console.log(token)
				if (token){
					$.db.set("token",token,120);
					let new_href = window.location.href.replaceAll("?token="+encodeURIComponent(token));
					location.href = new_href
				}
			},
					// toggle
			toToggle(){
				this.isAdmin = !this.isAdmin;
			},

					// 获取商品信息列表
			get_commodity_information() {
				let url = "~/api/commodity_information/get_list?";
														let param = {
									"page": 1,
					"size": 12
				}
								this.$get(url, param, (json) => {
					if (json.result) {
						this.list_commodity_information = json.result.list;
					}
				})
			},
					
			/**
			 * 当前年月日时分秒方法
			 * @param {Object} fmt
			 */
			dateFormat(fmt) {
				var myDate = new Date();
				var o = {
					"M+": myDate.getMonth() + 1, // 月份
					"d+": myDate.getDate(), // 日
					"h+": myDate.getHours(), // 小时
					"m+": myDate.getMinutes(), // 分
					"s+": myDate.getSeconds(), // 秒
					"q+": Math.floor((myDate.getMonth() + 3) / 3), // 季度
					"S": myDate.getMilliseconds() // 毫秒
				};
				if (/(y+)/.test(fmt))
					fmt = fmt.replace(RegExp.$1, (myDate.getFullYear() + "").substr(4 - RegExp.$1.length));
				for (var k in o)
					if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
						return fmt;
			},

			// 获取轮播图
			get_banner() {
			    this.$get("~/api/banner/get_list?", {}, (json) => {
			        if (json.result) {
			            this.list_slide = json.result.list;
			        }
			    });
			},
			// 获取导航栏
			get_menu() {
				var user_group = this.user_group;
			    this.$get(
			        "~/api/auth/get_list?",
			        {
			            page: "",
						user_group,
						get: 1,
						position: "top"
			        },
			        (json) => {
			            if (json.result) {
			                this.list_menu = json.result.list;
			            }
			        }
			    );
			},
			// 获取文章
			get_article() {
			    this.$get(
			        "~/api/article/get_list?",
			        {
			            page: 1,
			            size: 6,
			        },
			        (json) => {
			            if (json.result) {
			                var list_article = json.result.list;
			                this.list_article = list_article;
			            }
			        }
			    );
			},

			to_details(key,o,id) {
				if(!id){
					id = key + "_id";
				}
			    this.$router.push('/' + key + '/details?' + id + '=' + o[id]);
			}
		},
		mounted() {
					this.get_commodity_information();
								this.get_menu();
			this.get_banner();
			this.get_article();
		},
		computed: {
				    list_table_inventory_information() {
		        var list = this.list_commodity_information;
		        var list_table = [];
		        for (let i = 0; i < list.length; i++) {
		            list_table[i] = {};
		            this.vm_arr_commodity_information.map((o) => {
		                // 第二个中括号是对象的属性
		                list_table[i][o] = list[i][o] || "";
		            });
		        }
		        return list_table;
		    },
					

		    list_table_article() {
		        var list = this.list_article;
		        var list_table = [];
		        for (let i = 0; i < list.length; i++) {
		            list_table[i] = {};
		            this.vm_arr_article.map((o) => {
		                // 第二个中括号是对象的属性
		                list_table[i][o] = list[i][o];
		            });
		        }
		        return list_table;
		    },
		}
	};
</script>

<style scoped>
.page_root {
	background-color: var(--portal-bg);
	min-height: 100vh;
}

/* Hero Section */
.banner {
	padding-top: 20px;
}

.premium-swiper-container {
	margin: 0 auto;
}

.premium-swiper {
	height: 300px; /* Adjusted height for 1/3 width */
	border-radius: var(--portal-radius);
	overflow: hidden;
	box-shadow: var(--portal-shadow);
}

.premium-announcement-card {
	background: #fff;
	border-radius: var(--portal-radius);
	box-shadow: var(--portal-shadow);
	display: flex;
	flex-direction: column;
	overflow: hidden;
	border: 1px solid #f1f5f9;
}

.wide-announcement {
	width: 100% !important;
	height: 350px !important;
}

.wide-announcement .announcement_header {
	width: 100%;
	border-bottom: 1px solid #f1f5f9;
	border-right: none;
}

.wide-announcement .announcement_body {
	display: flex;
	align-items: center;
}

.announcement_header {
	padding: 15px 20px;
	border-bottom: 1px solid #f1f5f9;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: #f8fafc;
}

.announcement_title_text {
	font-weight: 700;
	color: var(--portal-text-main);
	font-size: 16px;
}

.announcement_more {
	font-size: 13px;
	color: var(--portal-text-muted);
}

.announcement_body {
	flex: 1;
	padding: 15px;
	overflow: hidden;
}

.content_row .el-row {
	display: flex;
	flex-wrap: wrap;
}

.content_row .el-col {
	display: flex;
}

.h-100 {
	height: 100%;
	width: 100%;
}

.unified-content-card {
	border-radius: var(--portal-radius) !important;
	border: 1px solid #f1f5f9 !important;
	box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05) !important;
	background: #fff;
}

.unified-content-card >>> .el-card__body {
	padding: 30px !important;
}

.content-column {
	height: 100%;
	display: flex;
	flex-direction: column;
}

.products-column {
	border-right: 1px solid #f1f5f9;
	padding-right: 35px !important;
}

.news-column {
	padding-left: 25px !important;
}

.list_article_box, .list_commodity_information_box {
	max-height: 450px;
	overflow-y: auto;
	padding-right: 5px;
}

/* Custom Scrollbar for Premium Feel */
.list_article_box::-webkit-scrollbar, 
.list_commodity_information_box::-webkit-scrollbar {
	width: 4px;
}

.list_article_box::-webkit-scrollbar-thumb, 
.list_commodity_information_box::-webkit-scrollbar-thumb {
	background: rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

.list_article_box::-webkit-scrollbar-track, 
.list_commodity_information_box::-webkit-scrollbar-track {
	background: transparent;
}

.products-column >>> .diy_view_list {
	display: flex !important;
	flex-wrap: wrap !important;
	margin: 0 -0.5rem !important;
}

.products-column >>> .diy_card.goods {
	width: calc(33.33% - 1rem) !important;
	margin: 0.5rem !important;
	display: flex !important;
	flex-direction: column !important;
}

.products-column >>> .diy_list_img_box {
	width: 100% !important;
	aspect-ratio: 1/1 !important;
	height: auto !important;
}

.section-header.mini {
	margin-bottom: 25px;
	padding-bottom: 12px;
	border-bottom: 2px solid #f8fafc;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.section-header.mini .title {
	font-size: 1.25rem;
	font-weight: 800;
	color: var(--portal-text-main);
	position: relative;
	padding-left: 15px;
}

.section-header.mini .title::before {
	content: "";
	position: absolute;
	left: 0;
	top: 50%;
	transform: translateY(-50%);
	width: 4px;
	height: 18px;
	background: var(--portal-theme);
	border-radius: 2px;
}

.premium-announcement-card {
	background: #f8fafc;
	border-radius: var(--portal-radius);
	border: 1px solid #f1f5f9;
	overflow: hidden;
	transition: all 0.3s ease;
}

.premium-announcement-card:hover {
	border-color: var(--portal-theme-light);
	box-shadow: var(--portal-shadow);
}

.announcement_header {
	padding: 18px 25px;
	background: #fff;
	border-bottom: 1px solid #f1f5f9;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.announcement_body {
	padding: 10px 20px;
}

.section-header.mini .title {
	font-size: 18px;
}

.section-header.mini .title::after {
	bottom: -12px;
	width: 40px;
}

/* Ensure lists don't wrap too much in 1/2 column */
.list_article_box >>> .diy_card {
	margin: 0.5rem 0 !important;
	width: 100% !important;
}

.list_commodity_information_box >>> .diy_card {
	margin: 0.5rem 0 !important;
	width: 100% !important;
}

@media (max-width: 996px) {
	.premium-hero {
		flex-direction: column;
	}
	.premium-swiper, .premium-announcement-card {
		width: 100%;
		height: auto;
		min-height: 250px;
	}
}
</style>
