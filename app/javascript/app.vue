<template>
  <v-app>
    <TheHeader />
    <v-content class="blue">
      <router-view />
    </v-content>
    <TheFooter />
  </v-app>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"

export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>

<style scoped>

</style>
