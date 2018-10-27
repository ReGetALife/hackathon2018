import React, {
  Component
} from 'react';
import { Motion, StaggeredMotion, spring } from 'react-motion'
import noop from 'react-props-noop'
import classNames from 'classnames/bind';
import { Link } from 'react-router-dom'
import { NavBar, Icon } from 'antd-mobile';
//import logo from '../../public/images/logo.svg'
//import BottomNav from '../../components/BottomNav'
import './home.css'


const Tooltip = (props) => <span className="tooltip">{props.text}</span>;

const ButtonGroup = (props) => <div className="button-group" style={props.style}>{props.children}</div>;

const Button = (props) => <button className={classNames('button', props.className)} style={props.style} onClick={props.onClick || noop}>{props.children}</button>;


class Menu extends Component {
  constructor() {
    super();
    
    this.state = {
      active: false,
    }
    
    this._onClick = this._onClick.bind(this);
  }
  
  _onClick() {
    this.setState({ 
      active: !this.state.active 
    });
  }

  render() {
    const iconArrayOne = ['mimi', 'shouzhang'];
    const iconArrayTwo = ['jinian', 'chengnuo'].reverse();
    const tooltipArrayOne = ['One', 'Two'];
    const tooltipArrayTwo = ['One', 'Two'].reverse();
    const iconJumpArrayOne = ['/secret', '/diary'];
    const iconJumpArrayTwo = ['/date', '/promise'].reverse();
    
    return (
      <div className="container">
        <ButtonGroup>
          <StaggeredMotion
            defaultStyles={[
              { x: -45, o: 0 },
              { x: -45, o: 0 },
            ]}
            styles={prevInterpolatedStyles => prevInterpolatedStyles.map((_, i) => {
              return i === prevInterpolatedStyles.length - 1
                ? {
                  x: spring(this.state.active ? 0 : -45, { stiffness: 330, damping: 20 }),
                  o: spring(this.state.active ? 1 : 0, { stiffness: 330, damping: 20 }),
                } : {
                  x: spring(prevInterpolatedStyles[i + 1].x, { stiffness: 330, damping: 20 }),
                  o: spring(prevInterpolatedStyles[i + 1].o, { stiffness: 330, damping: 20 }),
                };
            })}
          >
            {interpolatingStyles =>
              <ButtonGroup>
                {interpolatingStyles.map((style, i) =>
                  <Link to={iconJumpArrayOne[i]}
                  key={i}
                  >
                  <Button
                    key={i}
                    style={{
                      position: 'relative',
                      right: style.x,
                      opacity: style.o,
                      pointerEvents: this.state.active ? 'auto' : 'none',
                    }}
                  >
                    <Tooltip text={tooltipArrayOne[i]} />
                    {iconArrayOne[i]}
                 </Button>
                 </Link>
                )}
              </ButtonGroup>
            }
          </StaggeredMotion>
          
          <Motion
            defaultStyle={{ s: 0.675 }}
            style={{ s: spring(this.state.active ? 1 : 0.675, { stiffness: 330, damping: 14 }) }}
          >
            {interpolatingStyles =>
              <Button 
                className="button--large" 
                onClick={this._onClick} 
                style={{ 
                  transform: 'scale(' + interpolatingStyles.s + ')',
                }}
              >
                <span className={this.state.active ? 'icon active' : 'icon'} />
              </Button>
            }
          </Motion>
          
          <StaggeredMotion
            defaultStyles={[
              { x: -45, o: 0 },
              { x: -45, o: 0 },
            ]}
            styles={prevInterpolatedStyles => prevInterpolatedStyles.map((_, i) => {
              return i === 0
                ? {
                  x: spring(this.state.active ? 0 : -45, { stiffness: 330, damping: 20 }),
                  o: spring(this.state.active ? 1 : 0, { stiffness: 330, damping: 20 }),
                } : {
                  x: spring(prevInterpolatedStyles[i - 1].x, { stiffness: 330, damping: 20 }),
                  o: spring(prevInterpolatedStyles[i - 1].o, { stiffness: 330, damping: 20 }),
                };
            })}
          >
            {interpolatingStyles =>
              <ButtonGroup>
                {interpolatingStyles.map((style, i) =>
                  <Link to={iconJumpArrayTwo[i]}
                  key={i}
                  >
                  <Button
                    key={i}
                    style={{
                      position: 'relative',
                      left: style.x,
                      opacity: style.o,
                      pointerEvents: this.state.active ? 'auto' : 'none',
                    }}
                  >
                    <Tooltip text={tooltipArrayTwo[i]} />
                    {iconArrayTwo[i]}
                  </Button>
                  </Link>
                )}
              </ButtonGroup>
            }
          </StaggeredMotion>
        </ButtonGroup>
      </div>
    );
  }
}


const Home = () => (
  <div>
    <div>
    <NavBar
      mode="light"
      icon={<img src={require('../../public/logo.png')} width="40%" height="20%" alt="icon" />}
      onLeftClick={() => console.log('onLeftClick')}
      rightContent={[
        <Icon key="1" type="ellipsis" />,
      ]}
    >In Love</NavBar>
    </div>
    <div className="home__logo--container">
      <span className="home__logo--text"> In Love  </span>
    </div>
    <div className="home__slogan--container">
      <h1 className="home__slogan--title"> </h1>
      <p className="home__slogan--text">
           
      </p>
    </div>
    <Menu />
  </div>
  
)

export default Home



