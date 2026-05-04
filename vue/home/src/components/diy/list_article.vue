<template>
	<nav class="list_article list list-x item-tb">
		<!-- 文章详情 -->
		<router-link class="article_warp" v-for="(o, i) in list" :key="i"
			:to="'/article/details?' + vm.article_id + '=' + o[vm.article_id]">
			<div class="article">
				<div class="media">
					<div class="icon">
						<img :src="o[vm.img] ? $fullUrl(o[vm.img]) : '../../../public/img/default.png'"
							v-default-img="'../../../public/img/default.png'" />
					</div>
				</div>
				<div class="doc">
					<div class="title ellipsis_2" style="min-height: 2.8rem">
						{{ o[vm.title] }}
					</div>
					<div class="interact desc">
						<span class="praise">
							<b-icon icon="hand-thumbs-up"/>
							{{ o[vm.praise_len] }}
						</span>
						<span class="see">
							<b-icon icon="eye"/>
							{{ o[vm.views] }}
						</span>
					</div>
					<div class="time">{{ $toTime(o[vm.create_time],"yyyy-MM-dd hh:mm:ss") }}</div>
				</div>
			</div>
		</router-link>
	</nav>
</template>

<script>
	export default {
		props: {
			list: {
				type: Array,
				default: function() {
					return [];
				},
			},
			vm: {
				type: Object,
				default: function() {
					return {
						img: "img",
						article_id: "article_id",
						title: "title",
						description: "description",
						title: "title",
						create_time: "create_time",
						content: "content",
						praise_len: "praise_len",
						views: "views",
					};
				},
			},
		},
		methods: {},
	};
</script>

<style scoped>

	.article_warp {
		display: flex;
		width: calc(100% - 1rem);
		margin: 0.5rem;
		flex-direction: row;
		background-color: white;
		border-radius: 0.5rem;
		transition: all 0.3s ease;
		padding: 10px;
	}

	.article_warp:hover {
		background: #f8fafc;
		transform: translateX(5px);
	}

	.article {
		width: 100%;
		display: flex;
		flex-direction: row;
		align-items: center;
	}

	.media {
		width: 80px;
		height: 60px;
		flex-shrink: 0;
		margin-right: 15px;
	}

	.icon img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		border-radius: 4px;
	}

	.doc {
		flex: 1;
		min-width: 0;
	}

	.title {
		font-size: 0.9rem;
		font-weight: 700;
		margin-bottom: 5px;
		color: var(--portal-text-main);
	}

	.interact {
		font-size: 0.8rem;
		color: var(--portal-text-muted);
	}

	.time {
		font-size: 0.75rem;
		color: #999;
		margin-top: 5px;
	}

	.ellipsis_2 {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
	}

	@media (max-width: 992px) {

		.article_warp {
			width: calc(33% - 1rem);;
		}

	}

	@media (max-width: 768px) {

		.article_warp {
			width: calc(50% - 1rem);;
		}

	}

</style>
