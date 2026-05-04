<template>
    <div class="vertical-notice-container" :style="{height: '300px'}">
      <div class="notice-list-wrapper" :class="{animate: list.length > 1}">
        <div v-for="(o, i) in list" :key="i" class="notice-item">
          <router-link class="swiper_notice" :to="'/notice/details?notice_id='+o.notice_id">
            <p class="title">{{o.title}}</p>
            <div class="notice-content-wrapper">
              <p class="content" v-html="o.content"></p>
            </div>
          </router-link>
        </div>
        <!-- Duplicate first item for seamless loop if needed, but simple scroll is better for now -->
      </div>
    </div>
</template>


<script>
export default {
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
    // vm: {
    //   type: Object,
    //   default: function () {
    //     return {
    //       title: "title",
    //     };
    //   },
    // },
  },
  data() {
    return {
      slide: 0,
      sliding: null,
    };
  },
  methods: {
    onSlideStart(slide) {
      this.sliding = true;
    },
    onSlideEnd(slide) {
      this.sliding = false;
    },
  },
};
</script>


<style scoped>

  .vertical-notice-container {
    width: 100%;
    overflow: hidden;
    position: relative;
    background: #fff;
  }

  .notice-list-wrapper {
    position: relative;
    top: 0;
  }

  .notice-list-wrapper.animate {
    animation: verticalScroll 20s linear infinite;
  }

  .notice-list-wrapper.animate:hover {
    animation-play-state: paused;
  }

  @keyframes verticalScroll {
    0% { top: 0; }
    100% { top: -100%; }
  }

  .notice-item {
    padding-bottom: 20px;
    border-bottom: 1px solid #f8fafc;
  }

  .swiper_notice {
    display: block;
    text-decoration: none !important;
  }

  .title {
    padding: 15px 20px;
    margin: 0;
    font-size: 1.1rem;
    font-weight: 700;
    color: var(--portal-text-main);
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
