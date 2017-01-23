'use babel';

import LoLanguageView from './lo-language-view';
import { CompositeDisposable } from 'atom';

export default {

  loLanguageView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.loLanguageView = new LoLanguageView(state.loLanguageViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.loLanguageView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'lo-language:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.loLanguageView.destroy();
  },

  serialize() {
    return {
      loLanguageViewState: this.loLanguageView.serialize()
    };
  },

  toggle() {
    console.log('LoLanguage was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
