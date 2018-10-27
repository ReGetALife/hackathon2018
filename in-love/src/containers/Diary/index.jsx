import React from 'react'
//import logo from '../../public/images/logo.svg'
//import BottomNav from '../../components/BottomNav'
import './home.css'
import { NavBar, Icon,List,TextareaItem } from 'antd-mobile';
import { createForm } from 'rc-form';




class TextareaItemExample extends React.Component {
  render() {
    const { getFieldProps } = this.props.form;
    return (
      <div>
        <List renderHeader={() => 'Secret'}>
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
    <div>
      <TextareaItemExampleWrapper />
    </div>
    <div>
    </div>
  </div>
)

export default Home
