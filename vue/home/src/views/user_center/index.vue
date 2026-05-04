<template>
	<div class="page_user my_home" id="user_address">
		<div class="warp">
			<div class="container">
				<div class="row justify-content-between">
					<div class="col-12 col-md-3">
						<div class="card_menu">
							<list_admin_menu_user></list_admin_menu_user>
						</div>
					</div>
					<div class="col-12 col-md-9">
						<div class="card_addres pl-2">

							<!-- 用户信息卡片 -->
							<div class="uc-hero">
								<div class="uc-avatar-wrap">
									<img :src="avatarUrl" class="uc-avatar" @error="onAvatarError" />
									<span class="uc-online-dot"></span>
								</div>
								<div class="uc-hero-info">
									<h2 class="uc-name">{{ userInfo.nickname || userInfo.username || '用户' }}</h2>
									<div class="uc-meta-row">
										<span class="uc-badge" v-if="userInfo.user_gender !== null && userInfo.user_gender !== undefined">
											{{ userInfo.user_gender === 0 ? '男' : '女' }}
										</span>
										<span class="uc-meta-item" v-if="userInfo.email">
											<i class="uc-icon">✉</i> {{ userInfo.email }}
										</span>
										<span class="uc-meta-item" v-if="userInfo.phone">
											<i class="uc-icon">📱</i> {{ userInfo.phone }}
										</span>
									</div>
									<div class="uc-join-time" v-if="userInfo.create_time">
										加入时间：{{ formatDate(userInfo.create_time) }}
									</div>
								</div>
							</div>

							<!-- 统计卡片 -->
							<div class="uc-stats-row">
								<div class="uc-stat-card" @click="goTo('/sales_information/table')">
									<div class="uc-stat-num">{{ stats.total }}</div>
									<div class="uc-stat-label">全部订单</div>
								</div>
								<div class="uc-stat-card uc-stat-warn" @click="goToUnpaid">
									<div class="uc-stat-num">{{ stats.unpaid }}</div>
									<div class="uc-stat-label">待支付</div>
								</div>
								<div class="uc-stat-card uc-stat-success" @click="goToPaid">
									<div class="uc-stat-num">{{ stats.paid }}</div>
									<div class="uc-stat-label">已支付</div>
								</div>
								<div class="uc-stat-card uc-stat-purple" @click="goTo('/user/collect')">
									<div class="uc-stat-num">{{ stats.collect }}</div>
									<div class="uc-stat-label">我的收藏</div>
								</div>
							</div>

							<!-- 最近订单 -->
							<div class="uc-section" v-if="recentOrders.length > 0">
								<div class="uc-section-header">
									<span class="uc-section-title">最近订单</span>
									<span class="uc-section-more" @click="goTo('/sales_information/table')">查看全部 →</span>
								</div>
								<div class="uc-order-list">
									<div class="uc-order-item" v-for="order in recentOrders" :key="order.sales_information_id">
										<div class="uc-order-left">
											<div class="uc-order-name">{{ order.product_name || order.product_code }}</div>
											<div class="uc-order-no">订单号：{{ order.sales_order_number }}</div>
											<div class="uc-order-time">{{ formatDate(order.create_time) }}</div>
										</div>
										<div class="uc-order-right">
											<div class="uc-order-price">¥ {{ order.total_order_price || order.commodity_price }}</div>
											<span class="uc-pay-tag" :class="order.pay_state === '已支付' ? 'paid' : 'unpaid'">
												{{ order.pay_state || '未支付' }}
											</span>
										</div>
									</div>
								</div>
							</div>

							<!-- 空状态 -->
							<div class="uc-empty" v-if="loaded && recentOrders.length === 0">
								<div class="uc-empty-icon">📦</div>
								<div class="uc-empty-text">暂无订单记录</div>
								<div class="uc-empty-btn" @click="goTo('/commodity_information/table')">去购买商品</div>
							</div>

							<!-- 加载中 -->
							<div class="uc-loading" v-if="!loaded">
								<div class="uc-spinner"></div>
								<span>加载中...</span>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import list_admin_menu_user from "@/components/diy/list_admin_menu_user.vue";
	import mixin from "@/mixins/page.js";

	export default {
		mixins: [mixin],
		data() {
			return {
				userInfo: {},
				recentOrders: [],
				stats: {
					total: 0,
					unpaid: 0,
					paid: 0,
					collect: 0,
				},
				loaded: false,
			};
		},
		computed: {
			avatarUrl() {
				const avatar = this.userInfo.avatar;
				if (!avatar || avatar === '/img/default.png') return '/img/default.png';
				if (avatar.startsWith('http')) return avatar;
				return this.$fullUrl(avatar) || '/img/default.png';
			}
		},
		mounted() {
			this.loadAll();
		},
		methods: {
			async loadAll() {
				try {
					await this.loadUserInfo();
					await this.loadOrders();
					await this.loadCollect();
				} catch (e) {
					console.error("加载个人中心数据失败:", e);
				} finally {
					this.loaded = true;
				}
			},

			async loadUserInfo() {
				const storeUser = this.$store.state.user;
				if (storeUser && storeUser.user_id) {
					// 先用store里的数据
					this.userInfo = { ...storeUser };
					// 请求用户详细信息 (使用合并后的user接口)
					const json = await this.$get(
						`~/api/user/get_obj?user_id=${storeUser.user_id}`,
						null, null
					);
					if (json && json.result && json.result.obj) {
						this.userInfo = { ...storeUser, ...json.result.obj };
					}
				}
			},

			async loadOrders() {
				const userId = this.$store.state.user.user_id;
				if (!userId) return;
				const json = await this.$get(
					`~/api/sales_information/get?source_user_id=${userId}&size=5&page=1&orderby=create_time desc`,
					null, null
				);
				if (json && json.result) {
					this.recentOrders = json.result.list || [];
					this.stats.total = json.result.count || this.recentOrders.length;
				}
				// 统计未支付
				const jsonUnpaid = await this.$get(
					`~/api/sales_information/get?source_user_id=${userId}&pay_state=未支付&size=1&page=1`,
					null, null
				);
				if (jsonUnpaid && jsonUnpaid.result) {
					this.stats.unpaid = jsonUnpaid.result.count || 0;
				}
				// 统计已支付
				const jsonPaid = await this.$get(
					`~/api/sales_information/get?source_user_id=${userId}&pay_state=已支付&size=1&page=1`,
					null, null
				);
				if (jsonPaid && jsonPaid.result) {
					this.stats.paid = jsonPaid.result.count || 0;
				}
			},

			async loadCollect() {
				const userId = this.$store.state.user.user_id;
				if (!userId) return;
				const json = await this.$get(
					`~/api/collect/get?userid=${userId}&size=1&page=1`,
					null, null
				);
				if (json && json.result) {
					this.stats.collect = json.result.count || 0;
				}
			},

			formatDate(ts) {
				if (!ts) return '';
				const d = new Date(ts);
				return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
			},

			goTo(path) {
				this.$router.push({ path });
			},

			goToUnpaid() {
				this.$router.push({ path: '/sales_information/table', query: { pay_state: '未支付' } });
			},

			goToPaid() {
				this.$router.push({ path: '/sales_information/table', query: { pay_state: '已支付' } });
			},

			onAvatarError(e) {
				e.target.src = '/img/avatar.png';
			}
		},
		components: {
			list_admin_menu_user,
		},
	};
</script>

<style scoped>
.container {
	min-height: 800px;
}

/* 用户信息卡片 */
.uc-hero {
	display: flex;
	align-items: center;
	gap: 20px;
	background: linear-gradient(135deg, #1a6fa8 0%, #1d9e75 100%);
	border-radius: 14px;
	padding: 28px 28px;
	margin-bottom: 20px;
	color: #fff;
}

.uc-avatar-wrap {
	position: relative;
	flex-shrink: 0;
}

.uc-avatar {
	width: 76px;
	height: 76px;
	border-radius: 50%;
	border: 3px solid rgba(255,255,255,0.5);
	object-fit: cover;
	background: rgba(255,255,255,0.2);
}

.uc-online-dot {
	position: absolute;
	bottom: 4px;
	right: 4px;
	width: 14px;
	height: 14px;
	background: #4ade80;
	border-radius: 50%;
	border: 2px solid #fff;
}

.uc-hero-info {
	flex: 1;
	min-width: 0;
}

.uc-name {
	font-size: 22px;
	font-weight: 700;
	margin: 0 0 8px;
	color: #fff;
}

.uc-meta-row {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	align-items: center;
	margin-bottom: 6px;
}

.uc-badge {
	background: rgba(255,255,255,0.25);
	border-radius: 20px;
	padding: 2px 10px;
	font-size: 12px;
}

.uc-meta-item {
	font-size: 13px;
	opacity: 0.85;
}

.uc-icon {
	font-style: normal;
	margin-right: 3px;
}

.uc-join-time {
	font-size: 12px;
	opacity: 0.65;
	margin-top: 4px;
}

/* 统计卡片 */
.uc-stats-row {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 12px;
	margin-bottom: 24px;
}

.uc-stat-card {
	background: #fff;
	border: 1px solid #e8f0f7;
	border-radius: 12px;
	padding: 18px 10px;
	text-align: center;
	cursor: pointer;
	transition: box-shadow 0.2s, transform 0.2s;
}

.uc-stat-card:hover {
	box-shadow: 0 4px 18px rgba(26,111,168,0.13);
	transform: translateY(-2px);
}

.uc-stat-num {
	font-size: 28px;
	font-weight: 700;
	color: #1a6fa8;
	line-height: 1;
	margin-bottom: 6px;
}

.uc-stat-warn .uc-stat-num { color: #e6a817; }
.uc-stat-success .uc-stat-num { color: #1d9e75; }
.uc-stat-purple .uc-stat-num { color: #7c6fdf; }

.uc-stat-label {
	font-size: 12px;
	color: #888;
}

/* 最近订单 */
.uc-section {
	background: #fff;
	border: 1px solid #e8f0f7;
	border-radius: 12px;
	overflow: hidden;
}

.uc-section-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16px 20px;
	border-bottom: 1px solid #f0f4f8;
}

.uc-section-title {
	font-size: 15px;
	font-weight: 600;
	color: #1a2740;
}

.uc-section-more {
	font-size: 13px;
	color: #1a6fa8;
	cursor: pointer;
}

.uc-section-more:hover {
	text-decoration: underline;
}

.uc-order-list {
	padding: 0 8px;
}

.uc-order-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 14px 12px;
	border-bottom: 1px solid #f5f8fb;
	transition: background 0.15s;
}

.uc-order-item:last-child {
	border-bottom: none;
}

.uc-order-item:hover {
	background: #f8fbff;
}

.uc-order-name {
	font-size: 14px;
	font-weight: 500;
	color: #222;
	margin-bottom: 4px;
}

.uc-order-no {
	font-size: 12px;
	color: #aaa;
	margin-bottom: 2px;
}

.uc-order-time {
	font-size: 12px;
	color: #bbb;
}

.uc-order-right {
	text-align: right;
}

.uc-order-price {
	font-size: 16px;
	font-weight: 600;
	color: #e05c1a;
	margin-bottom: 6px;
}

.uc-pay-tag {
	display: inline-block;
	font-size: 11px;
	padding: 2px 8px;
	border-radius: 20px;
}

.uc-pay-tag.paid {
	background: #e6f7f0;
	color: #1d9e75;
}

.uc-pay-tag.unpaid {
	background: #fff3e0;
	color: #e6a817;
}

/* 空状态 */
.uc-empty {
	text-align: center;
	padding: 60px 20px;
	color: #bbb;
}

.uc-empty-icon {
	font-size: 48px;
	margin-bottom: 12px;
}

.uc-empty-text {
	font-size: 14px;
	margin-bottom: 16px;
}

.uc-empty-btn {
	display: inline-block;
	background: #1a6fa8;
	color: #fff;
	padding: 8px 22px;
	border-radius: 20px;
	font-size: 13px;
	cursor: pointer;
}

/* 加载 */
.uc-loading {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	padding: 40px;
	color: #aaa;
	font-size: 14px;
}

.uc-spinner {
	width: 20px;
	height: 20px;
	border: 2px solid #e0e8f0;
	border-top-color: #1a6fa8;
	border-radius: 50%;
	animation: spin 0.8s linear infinite;
}

@keyframes spin {
	to { transform: rotate(360deg); }
}

/* 响应式 */
@media (max-width: 600px) {
	.uc-stats-row {
		grid-template-columns: repeat(2, 1fr);
	}
	.uc-hero {
		flex-direction: column;
		text-align: center;
	}
	.uc-meta-row {
		justify-content: center;
	}
}
</style>