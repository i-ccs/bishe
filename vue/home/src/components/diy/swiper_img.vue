<template>
  <b-carousel
    id="carousel"
    v-model="slide"
    :interval="4000"
    controls
    indicators
    background="#ababab"
    style="text-shadow: 1px 1px 2px #333"
    @sliding-start="onSlideStart"
    @sliding-end="onSlideEnd"
  >
    <b-carousel-slide
      v-for="(o, i) in list"
      :key="i"
    >
      <template #img>
        <a v-if="o[vm.url]" target="_blank" :href="o[vm.url]">
          <div class="swiper-imgs" :style="{backgroundImage: 'url(' + $fullUrl(o[vm.img]) + ')'}"></div>
        </a>
        <div v-else class="swiper-imgs" :style="{backgroundImage: 'url(' + $fullUrl(o[vm.img]) + ')'}"></div>
        <!-- <img
          class="d-block w-100"
          style="max-height:300px"
          :src="$fullUrl(fullImg(o[vm.img]))"
          :alt="o[vm.title]"
        /> -->
      </template>
    </b-carousel-slide>
  </b-carousel>
</template>

<script>
import mixin from "@/mixins/component.js";
export default {
  mixins: [mixin],
  props: {
    list: {
      type: Array,
      default: function () {
        return [];
      },
    },
    vm: {
      type: Object,
      default: function () {
        return {
          img: "img",
          title: "title",
          url: "url",
        };
      },
    },
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
    // fullImg(img){
    //   return "/api/img/slide/"+img;
    // },
  },
};
</script>

<style scoped>
#carousel {
	height: 100%;
}

.swiper-imgs {
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center;
	height: 100%; 
	min-height: 300px;
	transition: transform 0.5s ease;
}

/* Custom Indicators */
#carousel >>> .carousel-indicators {
	bottom: 20px;
}

#carousel >>> .carousel-indicators li {
	width: 12px;
	height: 4px;
	border-radius: 2px;
	background-color: rgba(255, 255, 255, 0.5);
	border: none;
	margin: 0 4px;
	transition: all 0.3s ease;
}

#carousel >>> .carousel-indicators li.active {
	width: 24px;
	background-color: #fff;
}

/* Custom Controls */
#carousel >>> .carousel-control-prev,
#carousel >>> .carousel-control-next {
	width: 40px;
	height: 40px;
	background: rgba(0, 0, 0, 0.2);
	border-radius: 50%;
	top: 50%;
	transform: translateY(-50%);
	margin: 0 20px;
	opacity: 0;
	transition: all 0.3s ease;
}

#carousel:hover >>> .carousel-control-prev,
#carousel:hover >>> .carousel-control-next {
	opacity: 1;
}

#carousel >>> .carousel-control-prev:hover,
#carousel >>> .carousel-control-next:hover {
	background: rgba(0, 0, 0, 0.4);
}

#carousel >>> .carousel-control-prev-icon,
#carousel >>> .carousel-control-next-icon {
	width: 20px;
	height: 20px;
}

@media (max-width: 996px) {
	.swiper-imgs {
		height: 250px;
	}
}
</style>
