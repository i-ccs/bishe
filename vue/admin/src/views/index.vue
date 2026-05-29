<template>
	<div class="page_root" id="root_index">
		<div class="warp">
			<div class="container-fluid">
				<!-- Welcome Banner -->
				<div class="premium-welcome">
					<div class="welcome-text">
						<h2>{{ greeting }}，{{ $store.state.user.nick_name || $store.state.user.user_na }}</h2>
						<p>欢迎回到供应链端电商管理系统。今天是 {{ currentDate }}，祝您生活愉快！</p>
					</div>
					<div class="welcome-img">
						<i class="el-icon-sunny" v-if="greeting === '早上好'"></i>
						<i class="el-icon-sunset" v-else-if="greeting === '下午好'"></i>
						<i class="el-icon-moon" v-else></i>
					</div>
				</div>

				<!-- Stats Group Card -->
				<el-card class="stat-group-card">
					<div class="stat-item" @click="$router.push('/user/table')">
						<div class="stat-value">{{ user_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-purple">
								<i class="el-icon-user-solid"></i>
							</div>
							<div class="stat-label">用户数量</div>
						</div>
					</div>
					<div class="stat-item" @click="$router.push('/registered_user/table')">
						<div class="stat-value">{{ registered_user_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-green">
								<i class="el-icon-s-custom"></i>
							</div>
							<div class="stat-label">注册用户</div>
						</div>
					</div>
					<div class="stat-item" @click="$router.push('/sales_information/table')">
						<div class="stat-value">{{ sales_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-blue">
								<i class="el-icon-shopping-cart-2"></i>
							</div>
							<div class="stat-label">销售信息</div>
						</div>
					</div>
					<div class="stat-item" @click="$router.push('/inventory_information/table')">
						<div class="stat-value">{{ inventory_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-orange">
								<i class="el-icon-box"></i>
							</div>
							<div class="stat-label">库存信息</div>
						</div>
					</div>
					<div class="stat-item" @click="$router.push('/purchasing_information/table')">
						<div class="stat-value">{{ purchasing_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-cyan">
								<i class="el-icon-shopping-bag-1"></i>
							</div>
							<div class="stat-label">采购信息</div>
						</div>
					</div>
					<div class="stat-item" @click="$router.push('/supply_information/table')">
						<div class="stat-value">{{ supply_count }}</div>
						<div class="stat-body">
							<div class="stat-icon bg-gradient-red">
								<i class="el-icon-truck"></i>
							</div>
							<div class="stat-label">供应信息</div>
						</div>
					</div>
				</el-card>

				<!-- Main Dashboard Charts -->
				<!-- Combined Line Chart -->
				<el-card class="premium-chart-card">
					<div slot="header">
						<span>业务综合统计分析（销售、库存、采购）</span>
					</div>
					<div class="chart" id="chart_combined_business" style="height: 400px;"></div>
				</el-card>

				<!-- Distribution Charts Group -->
				<el-card class="premium-chart-card">
					<div slot="header">
						<span>业务分布综合分析（性别、供应、访问）</span>
					</div>
					<el-row :gutter="20">
						<el-col :span="8">
							<div class="chart" id="chart_user_gender"></div>
						</el-col>
						<el-col :span="8">
							<div class="chart" id="chart_supply_category"></div>
						</el-col>
						<el-col :span="8">
							<div class="chart" id="chart_views_source"></div>
						</el-col>
					</el-row>
				</el-card>
			</div>
		</div>
	</div>
</template>
<script>
	import mixin from "@/mixins/page.js";
	import echarts from "@/assets/js/echarts.min.js";

	export default {
		mixins: [mixin],
		name: "Home",
		data() {
			return {
				activeName: "third",
				user_count: 0,
				registered_user_count: 0,
				sales_count: 0,
				inventory_count: 0,
				purchasing_count: 0,
				supply_count: 0,
				charts: [],
				greeting: "",
				currentDate: ""
			};
		},
		created() {
			this.set_welcome_info();
		},
		mounted() {
			this.get_counts();
			this.init_charts();
			window.addEventListener('resize', this.handleResize);
		},
		destroyed() {
			window.removeEventListener('resize', this.handleResize);
		},
		methods: {
			get_counts() {
				this.$get("~/api/user/count?", null, (json) => { if (json.result || json.result === 0) this.user_count = json.result; });
				this.$get("~/api/user/count?", {user_group: "注册用户"}, (json) => { if (json.result || json.result === 0) this.registered_user_count = json.result; });
				this.$get("~/api/sales_information/count?", null, (json) => { if (json.result || json.result === 0) this.sales_count = json.result; });
				this.$get("~/api/inventory_information/count?", null, (json) => { if (json.result || json.result === 0) this.inventory_count = json.result; });
				this.$get("~/api/purchasing_information/count?", null, (json) => { if (json.result || json.result === 0) this.purchasing_count = json.result; });
				this.$get("~/api/supply_information/count?", null, (json) => { if (json.result || json.result === 0) this.supply_count = json.result; });
			},
			handleResize() {
				this.charts.forEach(chart => {
					chart.resize();
				});
			},
			set_welcome_info() {
				const hour = new Date().getHours();
				if (hour < 12) this.greeting = "早上好";
				else if (hour < 18) this.greeting = "下午好";
				else this.greeting = "晚上好";

				const date = new Date();
				const weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
				const week = weeks[date.getDay()];
				this.currentDate = `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${week}`;
			},
			init_charts() {
				this.get_combined_business_data();
				this.get_user_gender_data();
				this.get_supply_category_data();
				this.get_views_source_data();
			},
			async get_combined_business_data() {
				let pastDays = [];
				for (let i = 14; i >= 0; i--) {
					let d = new Date();
					d.setDate(d.getDate() - i);
					let month = (d.getMonth() + 1).toString().padStart(2, '0');
					let day = d.getDate().toString().padStart(2, '0');
					pastDays.push(`${d.getFullYear()}-${month}-${day}`);
				}
				let create_time_min = pastDays[0] + ' 00:00:00';
				
				const sales_res = await this.$get("~/api/sales_information/list_group?groupby=DATE(create_time)&create_time_min=" + create_time_min);
				const inventory_res = await this.$get("~/api/inventory_information/list_group?groupby=DATE(create_time)&create_time_min=" + create_time_min);
				const purchasing_res = await this.$get("~/api/purchasing_information/list_group?groupby=DATE(create_time)&create_time_min=" + create_time_min);

				const dateMap = {};
				pastDays.forEach(date => {
					dateMap[date] = { sales: 0, inventory: 0, purchasing: 0 };
				});

				const processRes = (res, key) => {
					if (res.result && res.result.list) {
						res.result.list.forEach(o => {
							const date = o[1];
							if (date && dateMap[date]) {
								dateMap[date][key] = o[0];
							}
						});
					}
				};

				processRes(sales_res, 'sales');
				processRes(inventory_res, 'inventory');
				processRes(purchasing_res, 'purchasing');

				const salesData = pastDays.map(d => dateMap[d].sales);
				const inventoryData = pastDays.map(d => dateMap[d].inventory);
				const purchasingData = pastDays.map(d => dateMap[d].purchasing);

				this.render_line_chart("chart_combined_business", "业务指标对比", pastDays, [
					{ name: '销售', data: salesData, color: '#409eff' },
					{ name: '库存', data: inventoryData, color: '#e6a23c' },
					{ name: '采购', data: purchasingData, color: '#67c23a' }
				]);
			},
			render_line_chart(id, title, categories, series) {
				var chartDom = document.getElementById(id);
				if (!chartDom) return;
				var myChart = echarts.init(chartDom);
				var option = {
					tooltip: { trigger: 'axis' },
					legend: { data: series.map(s => s.name), top: '10' },
					grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
					xAxis: { type: 'category', boundaryGap: false, data: categories },
					yAxis: { type: 'value' },
					series: series.map(s => ({
						name: s.name,
						type: 'line',
						smooth: true,
						data: s.data,
						itemStyle: { color: s.color },
						areaStyle: {
							color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
								{ offset: 0, color: s.color + '80' },
								{ offset: 1, color: s.color + '00' }
							])
						}
					}))
				};
				myChart.setOption(option);
				this.charts.push(myChart);
			},
			get_user_gender_data() {
				this.$get("~/api/registered_user/list_group?groupby=user_gender", null, (json) => {
					if (json.result) {
						var data = json.result.list.map(o => {
							return {
								value: o[0],
								name: o[1] === 0 ? "男" : "女"
							}
						});
						this.render_pie_chart("chart_user_gender", "性别分布", data);
					}
				});
			},
			get_supply_category_data() {
				this.$get("~/api/supply_information/list_group?groupby=comm_category", null, (json) => {
					if (json.result) {
						var data = json.result.list.map(o => {
							return {
								value: o[0],
								name: o[1]
							}
						});
						this.render_pie_chart("chart_supply_category", "供应分布", data);
					}
				});
			},
			get_views_source_data() {
				this.$get("~/api/views/list_group?groupby=source_table", null, (json) => {
					if (json.result) {
						var data = json.result.list.map(o => {
							var name = o[1];
							if(name === 'commodity_information') name = '商品信息';
							else if(name === 'article') name = '文章';
							else if(name === 'announcement') name = '公告';
							return {
								value: o[0],
								name: name
							}
						});
						this.render_pie_chart("chart_views_source", "访问分布", data);
					}
				});
			},
			render_pie_chart(id, title, data) {
				var chartDom = document.getElementById(id);
				if (!chartDom) return;
				var myChart = echarts.init(chartDom);
				var option = {
					title: {
						text: title,
						left: 'center'
					},
					tooltip: {
						trigger: 'item'
					},
					legend: {
						orient: 'vertical',
						left: 'left',
						top: 'bottom'
					},
					series: [
						{
							name: title,
							type: 'pie',
							radius: '50%',
							data: data,
							emphasis: {
								itemStyle: {
									shadowBlur: 10,
									shadowOffsetX: 0,
									shadowColor: 'rgba(0, 0, 0, 0.5)'
								}
							}
						}
					]
				};
				myChart.setOption(option);
				this.charts.push(myChart);
			},
			async get_nick_name(list, flag) {
				if (flag) {
					for (let i = 0; i < list.length; i++) {
						await this.$get(
								"~/api/user/get_obj?user_id=" + list[i],
								null,
								(json) => {
									if (json.result) {
										list[i] = json.result.obj.nick_name;
									}
								});
					}
				} else {
					for (let i = 0; i < list.length; i++) {
						await this.$get(
								"~/api/user/get_obj?user_id=" + list[i].name,
								null,
								(json) => {
									if (json.result) {
										list[i].name = json.result.obj.nick_name;
									}
								});
					}
				}
			},

		},
		computed: {
			recognitionHeight() {
				return "830px"
			},
			recognitionUrl() {
				return "https://www.faceplusplus.com.cn/${model.filter.recognitionType}/"
			}
		}
	};
</script>

<style scoped="scoped">
	.chart {
		display: block;
		width: 100%;
		height: 300px;
		padding: 1rem;
		position: relative;
	}

	.el-col {
		padding: 0.5rem;
	}

	.card {
		overflow: hidden;
	}

	.iframe_box, .iframe_box_change {
		width: 100%;
		height: 1180px;
		position: relative;
		margin-top: 25px;
	}

	.iframe_box_change {
		height: 580px;
		padding-top: 50px;
	}

	.iframe_box .iframe_box_content, .iframe_box_change .iframe_box_content {
		width: 100%;
		height: 100%;
	}

	.iframe_box_top {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100px;
		font-size: 25px;
		line-height: 100px;
		background: #fff;
		z-index: 99999999;
		padding-left: 50px;
	}

	#iframe_box_face div::before {
		content: '';
		width: 100px;
		position: absolute;
		top: 154px;
		right: 129px;
		z-index: 999;
		height: 20px;
		background-color: #FFFFFF;
	}

	#iframe_box_face > h1 {
		margin-top: 100px;
		margin-bottom: 20px;
	}
</style>
