<template>
  <v-app>
    <TheHeader />
    <FlashMessage />
    <v-main class="grey lighten-4 accent-1">
      <router-view />
    </v-main>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"
import FlashMessage from "components/FlashMessage"

export default {
  components: {
    TheHeader,
    TheFooter,
    FlashMessage
  }
}
</script>

<style scoped>

</style>
