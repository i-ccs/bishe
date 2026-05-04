<template>
    <div class="vertical-notice-container" :style="{height: '200px'}">
      <div class="notice-list-wrapper" :class="{animate: list.length > 1}">
        <div v-for="(o, i) in list" :key="i" class="notice-item">
          <router-link class="swiper_notice" :to="'/notice/details?notice_id='+o.notice_id">
            <p class="title">{{o.title}}</p>
            <div class="notice-content-wrapper">
              <p class="content" v-html="o.content"></p>
            </div>
          </router-link>
        </div>
      </div>
    </div>
</template>

<script>
export default {
  props: {
    list: {
      type: Array,
      default: () => [],
    },
  }
};
</script>

<style scoped>
  .vertical-notice-container {
    width: 100%;
    overflow: hidden;
    position: relative;
    background: transparent;
  }

  .notice-list-wrapper {
    position: relative;
    top: 0;
  }

  .notice-list-wrapper.animate {
    animation: verticalScroll 25s linear infinite;
  }

  .notice-list-wrapper.animate:hover {
    animation-play-state: paused;
  }

  @keyframes verticalScroll {
    0% { transform: translateY(0); }
    100% { transform: translateY(-50%); }
  }

  .notice-item {
    padding: 15px 0;
    border-bottom: 1px dashed rgba(0,0,0,0.05);
  }

  .swiper_notice {
    display: block;
    text-decoration: none !important;
  }

  .title {
    padding: 0 20px;
    margin: 0 0 8px 0;
    font-size: 1.05rem;
    font-weight: 700;
    color: var(--portal-text-main);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .notice-content-wrapper {
    position: relative;
    padding: 0 20px 15px 20px;
  }

  .content {
    color: var(--portal-text-muted);
    font-size: 0.95rem;
    line-height: 1.6;
    text-align: left;
    margin: 0;
  }
</style>
