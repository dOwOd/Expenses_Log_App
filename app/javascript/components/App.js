import React from 'react';
import Modal from 'react-modal';
import { Button } from 'react-bootstrap';
import Style from '../stylesheets/app.module.css'

const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)',
    width     : "35%"
  }
};

class App extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    };

    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
  }

  openModal() {
    this.setState({modalIsOpen: true});
  }

  afterOpenModal() {
    // references are now sync'd and can be accessed.
    this.subtitle.style.color = '#0';
  }

  closeModal() {
    this.setState({modalIsOpen: false});
  }

  // これがないとWarning!が出る
  componentDidMount() {
    Modal.setAppElement('body');
  }

  render() {
    return (
      <div>
        <Button onClick={this.openModal} className="mr-2 d-inline">+</Button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Example Modal"
        >

          <h2 ref={subtitle => this.subtitle = subtitle}>経費を追加</h2>
          <form>
            <div>経費名</div>
              <input type="text" className={Style.input_form}/>
            <div>費用</div>
              <input type="number" className={Style.input_form}/>
            <div>支払日</div>
              <input className={Style.input_form}/>
            <div>詳しい説明</div>
              <input className={Style.input_form}/>
            <div>
              <input type="submit" value="登録する" className="btn btn-primary float-right mt-2"/>
            </div>
          </form>
        </Modal>
      </div>
    );
  }
}

export default App;