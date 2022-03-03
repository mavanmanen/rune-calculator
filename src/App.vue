<template>
  <div>
    <section class="hero is-primary">
      <div class="hero-body">
        <p class="title">
          Elden Ring Rune Calculator
        </p>
        <p class="subtitle">
          Calculate the value of a stack of runes and the totals.<br/>
          Clear a field by pressing the value or the total.
        </p>
      </div>
    </section>
    <section class="section">
      <div class="container">
        <form>
          <div class="field is-horizontal" v-for="(rune, index) in runes" :key="index">
            <div class="field-label">
              <label :for="index" class="label">
                {{ rune.name }} ({{ rune.value.toLocaleString() }})
              </label>
            </div>
            <div class="field-body">
              <div class="field has-addons">
                <div class="control is-expanded">
                  <input type="number" class="input is-dark has-text-right" :name="index" v-model="rune.count" min="0">
                </div>
                <div class="control">
                  <button class="button value-button has-text-right" type="button" @click="clear(index)">
                    {{ getValue(index).toLocaleString() }}
                  </button>
                </div>
              </div>
            </div>
          </div>

          <div class="field is-horizontal">
            <div class="field-label"></div>
            <div class="field-body">
              <div class="field">
                <div class="control">
                  <button class="button is-primary is-fullwidth has-text-right" type="button" @click="clear()">
                    {{ getTotalValue().toLocaleString() }}
                  </button>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </section>
    <footer class="footer">
      <div class="content has-text-centered">
        <p>
          <strong>Elden Ring Rune Calculator</strong> by <a href="https://github.com/mavanmanen">Mitchell van Manen</a>. The source code is licensed
          <a href="https://github.com/mavanmanen/rune-calculator/blob/main/LICENSE">GNU General Public License v3.0</a>
        </p>
      </div>
    </footer>
  </div>
</template>

<script lang="ts">
import { Vue } from 'vue-class-component';

class Rune {
  public name: string;
  public value: number;
  public count: number;

  constructor(name: string, value: number, count: number) {
    this.name = name;
    this.value = value;
    this.count = count;
  }
}

export default class App extends Vue {
  private _runeValueMap: Map<string, number> = new Map<string, number>([
    ["Golden Rune [1]", 200], 
    ["Golden Rune [2]", 400], 
    ["Golden Rune [3]", 800], 
    ["Golden Rune [4]", 1200], 
    ["Golden Rune [5]", 1600], 
    ["Golden Rune [6]", 2000], 
    ["Golden Rune [7]", 2500], 
    ["Golden Rune [8]", 3000], 
    ["Golden Rune [9]", 3800], 
    ["Golden Rune [10]", 5000], 
    ["Golden Rune [11]", 6200], 
    ["Golden Rune [12]", 7500], 
    ["Hero’s Rune [1]", 15000], 
    ["Hero’s Rune [2]", 20000], 
    ["Hero’s Rune [3]", 25000], 
    ["Hero’s Rune [4]", 30000], 
    ["Hero’s Rune [5]", 35000], 
    ["Lord’s Rune", 50000]
  ]);

  public runes: Array<Rune> = new Array<Rune>();

  beforeCreate?(): void {
    this._runeValueMap.forEach((value, key) => {
      this.runes.push(new Rune(key, value, 0));
    });
  }

  public getValue(index: number): number {
    const rune = this.runes[index];
    return rune.value * rune.count;
  }

  public getTotalValue(): number {
    return this.runes.reduce((total: number, rune: Rune) => {
      return total + rune.value * rune.count;
    }, 0);
  }

  public clear(index: number): void {
    this.runes[index].count = 0;
  }

  public clearAll(): void {
    this.runes.forEach((rune: Rune) => {
      rune.count = 0;
    });
  }
}
</script>

<style lang="scss">
@import "https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css";

.value-button {
  min-width: 150px;
}

.button.has-text-right {
    justify-content: flex-end;
}
</style>
