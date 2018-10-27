import React from 'react'
//import logo from '../../public/images/logo.svg'
//import BottomNav from '../../components/BottomNav'
import './home.css'
import { NavBar, Icon,List, Switch,TextareaItem } from 'antd-mobile';
import { createForm } from 'rc-form';
import { Button, WhiteSpace, WingBlank } from 'antd-mobile';




class SwitchExample extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      checked: false,
      checked1: true,
    };
  }

  render() {
    const { getFieldProps } = this.props.form;
    return (
      <List>
        <List.Item
          extra={<Switch
            {...getFieldProps('Switch1', {
              initialValue: !this.state.checked1,
              valuePropName: 'checked',
              onChange: (val) => {
                console.log(val);
                // Do not `setState` with rc-form
                // this.setState({ checked1: val });
              },
            })}
            onClick={(checked) => {
              // set new value
              this.props.form.setFieldsValue({
                Switch1: checked,
              });
            }}
          />}
        >公开</List.Item>

      </List>
    );
  }
}

const Se = createForm()(SwitchExample);


class TextareaItemExample extends React.Component {
  render() {
    const { getFieldProps } = this.props.form;
    return (
      <div>
        <List renderHeader={() => '记住我们的约定'}>
          <TextareaItem
            {...getFieldProps('count', {
    
            })}
            rows={8}
            count={300}
          />
        </List>
      </div>
    );
  }
}

const TextareaItemExampleWrapper = createForm()(TextareaItemExample);

const ButtonExample = () => (
  <WingBlank>
     <WhiteSpace />
     <WhiteSpace />
     <Button type="warning" disabled>直到永远</Button><WhiteSpace />
  </WingBlank>
);


const Home = () => (
  <div>
    <div>
    <NavBar
      mode="light"
      icon={<Icon type="left" />}
      onLeftClick={() => console.log('onLeftClick')}
      rightContent={[
        <Icon key="1" type="ellipsis" />,
      ]}
    >In Love</NavBar>
    </div>
    <TextareaItemExampleWrapper />
    <Se />
    <ButtonExample />
  </div>
)

export default Home
